@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

@@directive("'use client'")

@module("cn")
external cn: (string, option<string>) => string = "cn"

@react.componentWithProps(BaseUi.Types.DomProps.t)
let make = (props: BaseUi.Types.DomProps.t) =>
  <div dataSlot="table-container" className="cn-table-container">
    <table
      {...props}
      dataSlot={props.dataSlot->Option.getOr("table")}
      className={cn("cn-table", props.className)}
    />
  </div>

module Header = {
  @react.componentWithProps(BaseUi.Types.DomProps.t)
  let make = (props: BaseUi.Types.DomProps.t) =>
    <thead
      {...props}
      dataSlot={props.dataSlot->Option.getOr("table-header")}
      className={cn("cn-table-header", props.className)}
    />
}

module Body = {
  @react.componentWithProps(BaseUi.Types.DomProps.t)
  let make = (props: BaseUi.Types.DomProps.t) =>
    <tbody
      {...props}
      dataSlot={props.dataSlot->Option.getOr("table-body")}
      className={cn("cn-table-body", props.className)}
    />
}

module Footer = {
  @react.componentWithProps(BaseUi.Types.DomProps.t)
  let make = (props: BaseUi.Types.DomProps.t) =>
    <tfoot
      {...props}
      dataSlot={props.dataSlot->Option.getOr("table-footer")}
      className={cn("cn-table-footer", props.className)}
    />
}

module Row = {
  @react.componentWithProps(BaseUi.Types.DomProps.t)
  let make = (props: BaseUi.Types.DomProps.t) =>
    <tr
      {...props}
      dataSlot={props.dataSlot->Option.getOr("table-row")}
      className={cn("cn-table-row has-aria-expanded:bg-muted/50", props.className)}
    />
}

module Head = {
  @react.componentWithProps(BaseUi.Types.DomProps.t)
  let make = (props: BaseUi.Types.DomProps.t) =>
    <th
      {...props}
      dataSlot={props.dataSlot->Option.getOr("table-head")}
      className={cn("cn-table-head", props.className)}
    />
}

module Cell = {
  @react.componentWithProps(BaseUi.Types.DomProps.t)
  let make = (props: BaseUi.Types.DomProps.t) =>
    <td
      {...props}
      dataSlot={props.dataSlot->Option.getOr("table-cell")}
      className={cn("cn-table-cell", props.className)}
    />
}

module Caption = {
  @react.componentWithProps(BaseUi.Types.DomProps.t)
  let make = (props: BaseUi.Types.DomProps.t) =>
    <caption
      {...props}
      dataSlot={props.dataSlot->Option.getOr("table-caption")}
      className={cn("cn-table-caption", props.className)}
    />
}
