@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

@@directive("'use client'")

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

@react.component
let make = (~className=?, ~children=?, ~id=?, ~style=?, ~dir=?, ~onClick=?, ~onKeyDown=?) => {
  <div
    ?id
    ?style
    ?dir
    ?onClick
    ?onKeyDown
    dataSlot="table-container"
    className="cn-table-container"
  >
    <table
      ?id
      ?style
      ?onClick
      ?onKeyDown
      ?children
      dataSlot="table"
      className={cn("cn-table", className)}
    />
  </div>
}

module Header = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <thead
      ?id
      ?children
      ?style
      ?onClick
      ?onKeyDown
      dataSlot="table-header"
      className={cn("cn-table-header", className)}
    />
}

module Body = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <tbody
      ?id
      ?children
      ?style
      ?onClick
      ?onKeyDown
      dataSlot="table-body"
      className={cn("cn-table-body", className)}
    />
}

module Footer = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <tfoot
      ?id
      ?children
      ?style
      ?onClick
      ?onKeyDown
      dataSlot="table-footer"
      className={cn("cn-table-footer", className)}
    />
}

module Row = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?, ~dataState=?) =>
    <tr
      ?id
      ?children
      ?style
      ?onClick
      ?onKeyDown
      ?dataState
      dataSlot="table-row"
      className={cn(
        "cn-table-row",
        className,
      )}
    />
}

module Head = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~colSpan=?, ~onClick=?, ~onKeyDown=?) =>
    <th
      ?id
      ?children
      ?style
      ?colSpan
      ?onClick
      ?onKeyDown
      dataSlot="table-head"
      className={cn(
        "cn-table-head",
        className,
      )}
    />
}

module Cell = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~colSpan=?, ~onClick=?, ~onKeyDown=?) =>
    <td
      ?id
      ?children
      ?style
      ?colSpan
      ?onClick
      ?onKeyDown
      dataSlot="table-cell"
      className={cn("cn-table-cell", className)}
    />
}

module Caption = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <caption
      ?id
      ?children
      ?style
      ?onClick
      ?onKeyDown
      dataSlot="table-caption"
      className={cn("cn-table-caption", className)}
    />
}
