@@directive("'use client'")

@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

@react.componentWithProps(ReactAria.Table.props)
let make = (props: ReactAria.Table.props) =>
  <div dataSlot="table-container" className="cn-table-container">
    <ReactAria.Table
      {...props}
      dataSlot="table"
      className={cn("cn-table", props.className)}
    />
  </div>

module Header = {
  @react.componentWithProps(ReactAria.Table.Header.props)
  let make = (props: ReactAria.Table.Header.props<'item>) =>
    <ReactAria.Table.Header
      {...props}
      dataSlot="table-header"
      className={cn("cn-table-header", props.className)}
    />
}

module Body = {
  @react.componentWithProps(ReactAria.Table.Body.props)
  let make = (props: ReactAria.Table.Body.props<'item>) =>
    <ReactAria.Table.Body
      {...props}
      dataSlot="table-body"
      className={cn("cn-table-body data-empty:h-24 data-empty:text-center", props.className)}
    />
}

module Footer = {
  @react.componentWithProps(ReactAria.Table.Footer.props)
  let make = (props: ReactAria.Table.Footer.props<'item>) =>
    <ReactAria.Table.Footer
      {...props}
      dataSlot="table-footer"
      className={cn("cn-table-footer", props.className)}
    />
}

module Row = {
  @react.componentWithProps(ReactAria.Table.Row.props)
  let make = (props: ReactAria.Table.Row.props<'item>) =>
    <ReactAria.Table.Row
      {...props}
      dataSlot="table-row"
      className={cn(
        "cn-table-row cn-table-row-aria has-aria-expanded:bg-muted/50",
        props.className,
      )}
    />
}

module Head = {
  @react.componentWithProps(ReactAria.Table.Column.props)
  let make = (props: ReactAria.Table.Column.props) =>
    <ReactAria.Table.Column
      {...props}
      dataSlot="table-head"
      className={cn("cn-table-head cn-table-head-aria", props.className)}
    />
}

module Cell = {
  @react.componentWithProps(ReactAria.Table.Cell.props)
  let make = (props: ReactAria.Table.Cell.props) =>
    <ReactAria.Table.Cell
      {...props}
      dataSlot="table-cell"
      className={cn("cn-table-cell cn-table-cell-aria", props.className)}
    />
}

module Caption = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) =>
    <figcaption
      {...props}
      dataSlot="table-caption"
      className={cn("cn-table-caption text-center", props.className)}
    />
}
