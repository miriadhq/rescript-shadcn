@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

open BaseUi.Types

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

@react.component
let make = (~className="", ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?, ~dir=?) => {
  <nav
    ?id
    ?style
    ?children
    ?onClick
    ?onKeyDown
    ?dir
    ariaLabel="breadcrumb"
    dataSlot="breadcrumb"
    className
  />
}

module List = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <ol
      ?id
      ?style
      ?children
      ?onClick
      ?onKeyDown
      dataSlot="breadcrumb-list"
      className={cn(
        "text-muted-foreground flex flex-wrap items-center gap-1.5 text-sm wrap-break-word",
        className,
      )}
    />
}

module Item = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <li
      ?id
      ?style
      ?children
      ?onClick
      ?onKeyDown
      dataSlot="breadcrumb-item"
      className={cn("inline-flex items-center gap-1", className)}
    />
}

module Link = {
  @react.component
  let make = (
    ~className=?,
    ~children=?,
    ~id=?,
    ~href=?,
    ~target=?,
    ~style=?,
    ~onClick=?,
    ~onKeyDown=?,
    ~render=?,
  ) => {
    BaseUi.Render.use({
      defaultTagName: "a",
      ?render,
      props: {
        ?id,
        ?style,
        ?children,
        ?onClick,
        ?onKeyDown,
        ?href,
        ?target,
        render: React.null,
        dataSlot: "breadcrumb-link",
        className: cn("hover:text-foreground transition-colors", className),
      },
    })
  }
}

module Page = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <span
      ?id
      ?style
      ?children
      ?onClick
      ?onKeyDown
      ariaCurrent=#page
      ariaDisabled=true
      role="link"
      dataSlot="breadcrumb-page"
      className={cn("text-foreground font-normal", className)}
    />
}

module Separator = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) => {
    let content = switch children {
    | Some(content) => content
    | None => <Icons.ChevronRight className="cn-rtl-flip" />
    }
    <li
      ?id
      ?style
      ?onClick
      ?onKeyDown
      ariaHidden=true
      role="presentation"
      dataSlot="breadcrumb-separator"
      className={cn("[&>svg]:size-3.5", className)}
    >
      {content}
    </li>
  }
}

module Ellipsis = {
  @react.component
  let make = (~className=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <span
      ?id
      ?style
      ?onClick
      ?onKeyDown
      ariaHidden=true
      role="presentation"
      dataSlot="breadcrumb-ellipsis"
      className={cn("flex size-5 items-center justify-center [&>svg]:size-4", className)}
    >
      <Icons.MoreHorizontal />
      <span className="sr-only"> {"More"->React.string} </span>
    </span>
}
