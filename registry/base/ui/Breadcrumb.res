@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

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
    className={cn("cn-breadcrumb", Some(className))}
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
      className={cn("cn-breadcrumb-list flex flex-wrap items-center wrap-break-word", className)}
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
      className={cn("cn-breadcrumb-item inline-flex items-center", className)}
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
        className: cn("cn-breadcrumb-link", className),
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
      className={cn("cn-breadcrumb-page", className)}
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
      className={cn("cn-breadcrumb-separator", className)}
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
      className={cn("cn-breadcrumb-ellipsis flex items-center justify-center", className)}
    >
      <Icons.MoreHorizontal />
      <span className="sr-only"> {"More"->React.string} </span>
    </span>
}
