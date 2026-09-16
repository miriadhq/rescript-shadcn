@@directive("'use client'")

@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

@module("cn")
external cn: (string, option<string>) => string = "cn"

@react.componentWithProps(ReactAria.Table.props)
let make = (props: ReactAria.Table.props) => {
  let dataSlot = props.dataSlot->Option.getOr("table")
  <div dataSlot="table-container" className="cn-table-container">
    <ReactAria.Table {...props} dataSlot className={cn("cn-table", props.className)} />
  </div>
}
module Header = {
  @react.componentWithProps(ReactAria.Table.Header.props)
  let make = (props: ReactAria.Table.Header.props<'item>) => {
    let dataSlot = props.dataSlot->Option.getOr("table-header")
    <ReactAria.Table.Header
      {...props} dataSlot className={cn("cn-table-header", props.className)}
    />
  }
}

module Body = {
  @react.componentWithProps(ReactAria.Table.Body.props)
  let make = (props: ReactAria.Table.Body.props<'item>) => {
    let dataSlot = props.dataSlot->Option.getOr("table-body")
    <ReactAria.Table.Body
      {...props}
      dataSlot
      className={cn("cn-table-body data-empty:h-24 data-empty:text-center", props.className)}
    />
  }
}

module Footer = {
  @react.componentWithProps(ReactAria.Table.Footer.props)
  let make = (props: ReactAria.Table.Footer.props<'item>) => {
    let dataSlot = props.dataSlot->Option.getOr("table-footer")
    <ReactAria.Table.Footer
      {...props} dataSlot className={cn("cn-table-footer", props.className)}
    />
  }
}

module Row = {
  @react.componentWithProps(ReactAria.Table.Row.props)
  let make = (props: ReactAria.Table.Row.props<'item>) => {
    let dataSlot = props.dataSlot->Option.getOr("table-row")
    <ReactAria.Table.Row
      {...props}
      dataSlot
      className={cn(
        "cn-table-row cn-table-row-aria has-aria-expanded:bg-muted/50",
        props.className,
      )}
    />
  }
}

module Head = {
  @react.componentWithProps(ReactAria.Table.Column.props)
  let make = (props: ReactAria.Table.Column.props) => {
    let dataSlot = props.dataSlot->Option.getOr("table-head")
    <ReactAria.Table.Column
      {...props} dataSlot className={cn("cn-table-head cn-table-head-aria", props.className)}
    />
  }
}

module Cell = {
  @react.componentWithProps(ReactAria.Table.Cell.props)
  let make = (props: ReactAria.Table.Cell.props) => {
    let dataSlot = props.dataSlot->Option.getOr("table-cell")
    <ReactAria.Table.Cell
      {...props} dataSlot className={cn("cn-table-cell cn-table-cell-aria", props.className)}
    />
  }
}

module Caption = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) => {
    let dataSlot = props.dataSlot->Option.getOr("table-caption")
    <figcaption
      {...props} dataSlot className={cn("cn-table-caption text-center", props.className)}
    />
  }
}
