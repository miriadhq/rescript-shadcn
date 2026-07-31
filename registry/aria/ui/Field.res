@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

@@directive("'use client'")

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

module Orientation = {
  @unboxed
  type t =
    | @as("horizontal") Horizontal
    | @as("vertical") Vertical
    | @as("responsive") Responsive
}

module Variant = {
  @unboxed
  type t =
    | @as("legend") Legend
    | @as("label") Label
}

let fieldOrientationClass = (~orientation: Orientation.t) =>
  switch orientation {
  | Horizontal => "cn-field-orientation-horizontal flex-row items-center *:data-[slot=field-label]:flex-auto has-[>[data-slot=field-content]]:items-start has-[>[data-slot=field-content]]:[&>[role=checkbox],[role=radio]]:mt-px"
  | Responsive => "cn-field-orientation-responsive flex-col *:w-full [&>.sr-only]:w-auto @md/field-group:flex-row @md/field-group:items-center @md/field-group:*:w-auto @md/field-group:*:data-[slot=field-label]:flex-auto @md/field-group:has-[>[data-slot=field-content]]:items-start @md/field-group:has-[>[data-slot=field-content]]:[&>[role=checkbox],[role=radio]]:mt-px"
  | Vertical => "cn-field-orientation-vertical flex-col *:w-full [&>.sr-only]:w-auto"
  }

let fieldVariants = (~orientation=Orientation.Vertical) => {
  let base = "cn-field group/field flex w-full"
  `${base} ${fieldOrientationClass(~orientation)}`
}

module Set = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <fieldset
      ?id
      ?children
      ?style
      ?onClick
      ?onKeyDown
      dataSlot="field-set"
      className={cn(
        "cn-field-set flex flex-col",
        className,
      )}
    />
}

module Legend = {
  @react.component
  let make = (
    ~className=?,
    ~children=?,
    ~id=?,
    ~style=?,
    ~onClick=?,
    ~onKeyDown=?,
    ~variant=Variant.Legend,
  ) => {
    <legend
      ?id
      ?children
      ?style
      ?onClick
      ?onKeyDown
      dataSlot="field-legend"
      dataVariant={(variant :> string)}
      className={cn(
        "cn-field-legend",
        className,
      )}
    />
  }
}

module Group = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) =>
    <div
      {...props}
      dataSlot="field-group"
      className={cn(
        "cn-field-group group/field-group @container/field-group flex w-full flex-col",
        props.className,
      )}
    />
}

@react.component
let make = (
  ~className=?,
  ~children=?,
  ~id=?,
  ~style=?,
  ~onClick=?,
  ~onKeyDown=?,
  ~orientation=Orientation.Vertical,
  ~disabled=?,
  ~dataDisabled=?,
  ~dataInvalid=?,
  ~dir=?,
) => {
  <div
    ?id
    ?children
    ?style
    ?onClick
    ?onKeyDown
    ?disabled
    ?dataDisabled
    ?dataInvalid
    ?dir
    role="group"
    dataSlot="field"
    dataOrientation={(orientation :> string)}
    className={cn(fieldVariants(~orientation), className)}
  />
}

module Content = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <div
      ?id
      ?children
      ?style
      ?onClick
      ?onKeyDown
      dataSlot="field-content"
      className={cn("cn-field-content group/field-content flex flex-1 flex-col leading-snug", className)}
    />
}

module Label = {
  @react.component
  let make = (
    ~className=?,
    ~children=?,
    ~id=?,
    ~htmlFor=?,
    ~dir=?,
    ~onClick=?,
    ~onKeyDown=?,
    ~style=?,
  ) =>
    <Label
      ?id
      ?htmlFor
      ?dir
      ?onClick
      ?onKeyDown
      ?style
      dataSlot="field-label"
      className={cn(
        "cn-field-label cn-field-label-aria group/field-label peer/field-label flex w-fit has-[>[data-slot=field]]:w-full has-[>[data-slot=field]]:flex-col",
        className,
      )}
      ?children
    />
}

module Title = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <div
      ?id
      ?children
      ?style
      ?onClick
      ?onKeyDown
      dataSlot="field-label"
      className={cn(
        "cn-field-title flex w-fit items-center",
        className,
      )}
    />
}

module Description = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~dir=?, ~onClick=?, ~onKeyDown=?) =>
    <p
      ?id
      ?children
      ?style
      ?dir
      ?onClick
      ?onKeyDown
      dataSlot="field-description"
      className={cn(
        "cn-field-description leading-normal font-normal group-has-data-horizontal/field:text-balance last:mt-0 nth-last-2:-mt-1 [&>a:hover]:text-primary [&>a]:underline [&>a]:underline-offset-4",
        className,
      )}
    />
}

module Separator = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) => {
    let hasContent = children->Option.isSome
    <div
      ?id
      ?style
      ?onClick
      ?onKeyDown
      dataSlot="field-separator"
      dataContent={hasContent}
      className={cn(
        "cn-field-separator relative",
        className,
      )}
    >
      <ReactAria.Separator
        orientation=Horizontal
        dataSlot="separator"
        className="absolute inset-0 top-1/2 bg-border shrink-0 data-horizontal:h-px data-horizontal:w-full data-vertical:w-px data-vertical:self-stretch"
      />
      {switch children {
      | Some(value) =>
        <span
          className="cn-field-separator-content bg-background relative mx-auto block w-fit"
          dataSlot="field-separator-content"
        >
          {value}
        </span>
      | None => React.null
      }}
    </div>
  }
}

module Error = {
  type t = {
    message: string,
  }
  @react.component
  let make = (~className=?, ~children=?, ~errors=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) => {
    let content = React.useMemo(() => {
      children->Option.getOr(
        switch errors {
        | None | Some([]) => React.null
        | Some(errors) =>
          let uniqueErrors =
            Map.fromArray(errors->Array.map(error => (error.message, error)))
            ->Map.values
            ->Iterator.toArray
          switch uniqueErrors {
          | [{message}] => message->React.string
          | errors =>
            <ul className="ml-4 flex list-disc flex-col gap-1">
              {errors
              ->Array.mapWithIndex(({message}, index) =>
                <li key={index->Int.toString}> {message->React.string} </li>
              )
              ->React.array}
            </ul>
          }
        },
      )
    }, (children, errors))

    <div
      ?id
      ?style
      ?onClick
      ?onKeyDown
      role="alert"
      dataSlot="field-error"
      className={cn("cn-field-error font-normal", className)}
    >
      {content}
    </div>
  }
}
