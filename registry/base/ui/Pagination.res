@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

module Size = {
  @unboxed
  type t =
    | @as("icon") Icon
    | @as("default") Default
}

@react.component
let make = (~className=?, ~children=?, ~id=?, ~dir=?, ~style=?, ~onClick=?, ~onKeyDown=?) => {
  <nav
    dataSlot="pagination"
    ?id
    ?style
    ?dir
    ?onClick
    ?onKeyDown
    role="navigation"
    ariaLabel="pagination"
    className={cn("mx-auto flex w-full justify-center", className)}
    ?children
  />
}

module Content = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) => {
    <ul
      dataSlot="pagination-content"
      ?id
      ?style
      ?onClick
      ?onKeyDown
      className={cn("flex items-center gap-0.5", className)}
      ?children
    />
  }
}

module Item = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?) =>
    <li dataSlot="pagination-item" ?id ?style ?className ?children />
}

module Link = {
  @react.component
  let make = (
    ~className="",
    ~isActive=false,
    ~size=Size.Icon,
    ~children=?,
    ~href=?,
    ~target=?,
    ~id=?,
    ~style=?,
    ~onClick=?,
    ~ariaLabel=?,
  ) => {
    <Button
      variant={isActive ? Outline : Ghost}
      size={(size :> Button.Size.t)}
      className
      nativeButton={false}
      render={<a
        ?id
        ?ariaLabel
        ?style
        ?href
        ?target
        ?onClick
        ariaCurrent=?{isActive ? Some(#page) : None}
        dataSlot="pagination-link"
        dataActive=isActive
      />}
      ?children
    />
  }
}

module Previous = {
  @react.component
  let make = (~className=?, ~text="Previous", ~href=?, ~target=?, ~id=?, ~style=?, ~onClick=?) => {
    <Link
      ariaLabel="Go to previous page"
      size={Size.Default}
      className={cn("pl-1.5!", className)}
      ?href
      ?target
      ?id
      ?style
      ?onClick
    >
      <Icons.ChevronLeft dataIcon="inline-start" className="cn-rtl-flip" />
      <span className="hidden sm:block"> {text->React.string} </span>
    </Link>
  }
}

module Next = {
  @react.component
  let make = (~className=?, ~text="Next", ~href=?, ~target=?, ~id=?, ~style=?, ~onClick=?) => {
    <Link
      ariaLabel="Go to next page"
      size={Size.Default}
      className={cn("pr-1.5!", className)}
      ?href
      ?target
      ?id
      ?style
      ?onClick
    >
      <span className="hidden sm:block"> {text->React.string} </span>
      <Icons.ChevronRight dataIcon="inline-end" className="cn-rtl-flip" />
    </Link>
  }
}

module Ellipsis = {
  @react.component
  let make = (~className=?, ~id=?, ~style=?) => {
    <span
      dataSlot="pagination-ellipsis"
      ?id
      ?style
      ariaHidden={true}
      className={cn(
        "flex size-8 items-center justify-center [&_svg:not([class*='size-'])]:size-4",
        className,
      )}
    >
      <Icons.MoreHorizontal />
      <span className="sr-only"> {"More pages"->React.string} </span>
    </span>
  }
}
