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
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) =>
    <fieldset
      {...props}
      dataSlot={props.dataSlot->Option.getOr("field-set")}
      className={cn("cn-field-set flex flex-col", props.className)}
    />
}

module Legend = {
  type props = {variant?: Variant.t, ...ReactAria.Types.DomProps.t}
  let domProps: props => ReactAria.Types.DomProps.t = %raw(`({variant, ...props}) => props`)

  @react.componentWithProps(props)
  let make = (props: props) => {
    let variant = props.variant->Option.getOr(Legend)
    <legend
      {...props->domProps}
      dataSlot={props.dataSlot->Option.getOr("field-legend")}
      dataVariant={(variant :> string)}
      className={cn("cn-field-legend", props.className)}
    />
  }
}

module Group = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) =>
    <div
      {...props}
      dataSlot={props.dataSlot->Option.getOr("field-group")}
      className={cn(
        "cn-field-group group/field-group @container/field-group flex w-full flex-col",
        props.className,
      )}
    />
}

type props = {orientation?: Orientation.t, ...ReactAria.Common.elementProps}
let domProps: props => ReactAria.Types.DomProps.t = %raw(`({orientation, ...props}) => props`)

@react.componentWithProps(props)
let make = (props: props) => {
  let orientation = props.orientation->Option.getOr(Vertical)
  <div
    {...props->domProps}
    role={props.role->Option.getOr("group")}
    dataSlot={props.dataSlot->Option.getOr("field")}
    dataOrientation={(orientation :> string)}
    className={cn(fieldVariants(~orientation), props.className)}
  />
}

module Content = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) =>
    <div
      {...props}
      dataSlot={props.dataSlot->Option.getOr("field-content")}
      className={cn(
        "cn-field-content group/field-content flex flex-1 flex-col leading-snug",
        props.className,
      )}
    />
}

module Label = {
  @react.componentWithProps(ReactAria.Label.props)
  let make = (props: ReactAria.Label.props) =>
    <Label
      {...props}
      dataSlot={props.dataSlot->Option.getOr("field-label")}
      className={cn(
        "cn-field-label cn-field-label-aria group/field-label peer/field-label flex w-fit has-[>[data-slot=field]]:w-full has-[>[data-slot=field]]:flex-col",
        props.className,
      )}
    />
}

module Title = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) =>
    <div
      {...props}
      dataSlot={props.dataSlot->Option.getOr("field-label")}
      className={cn("cn-field-title flex w-fit items-center", props.className)}
    />
}

module Description = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) =>
    <p
      {...props}
      dataSlot={props.dataSlot->Option.getOr("field-description")}
      className={cn(
        "cn-field-description leading-normal font-normal group-has-data-horizontal/field:text-balance last:mt-0 nth-last-2:-mt-1 [&>a]:underline [&>a]:underline-offset-4 [&>a:hover]:text-primary",
        props.className,
      )}
    />
}

module Separator = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) => {
    let hasContent = props.children->Option.isSome
    <div
      {...props}
      dataSlot={props.dataSlot->Option.getOr("field-separator")}
      dataContent={hasContent}
      className={cn("cn-field-separator relative", props.className)}
    >
      <Separator className="absolute inset-0 top-1/2" />
      {switch props.children {
      | Some(value) =>
        <span
          className="cn-field-separator-content relative mx-auto block w-fit bg-background"
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
    message?: string,
  }
  type props = {errors?: array<t>, ...ReactAria.Types.DomProps.t}
  let domProps: props => ReactAria.Types.DomProps.t = %raw(`({errors, ...props}) => props`)

  @react.componentWithProps(props)
  let make = (props: props) => {
    let content = React.useMemo(() => {
      props.children->Option.getOr(
        switch props.errors {
        | None | Some([]) => React.null
        | Some(errors) =>
          let uniqueErrors =
            Map.fromArray(
              errors
              ->Array.filterMap(error => error.message->Option.map(message => (message, error))),
            )
            ->Map.values
            ->Iterator.toArray
          switch uniqueErrors {
          | [{message}] => message->React.string
          | errors =>
            <ul className="ml-4 flex list-disc flex-col gap-1">
              {errors
              ->Array.filterMapWithIndex((error, index) =>
                error.message->Option.map(message =>
                  <li key={index->Int.toString}> {message->React.string} </li>
                )
              )
              ->React.array}
            </ul>
          }
        },
      )
    }, (props.children, props.errors))

    content == React.null
      ? React.null
      : <div
          {...props->domProps}
          role={props.role->Option.getOr("alert")}
          dataSlot={props.dataSlot->Option.getOr("field-error")}
          className={cn("cn-field-error font-normal", props.className)}
        >
          {content}
        </div>
  }
}
