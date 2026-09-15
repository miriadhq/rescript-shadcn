@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

@module("cn")
external cn: (string, option<string>) => string = "cn"

@react.componentWithProps(BaseUi.Types.DomProps.t)
let make = (props: BaseUi.Types.DomProps.t) => {
  let className = props.className->Option.getOr("")
  <nav
    {...props}
    ariaLabel={props.ariaLabel->Option.getOr("breadcrumb")}
    dataSlot={props.dataSlot->Option.getOr("breadcrumb")}
    className={cn("cn-breadcrumb", Some(className))}
  />
}

module List = {
  @react.componentWithProps(BaseUi.Types.DomProps.t)
  let make = (props: BaseUi.Types.DomProps.t) =>
    <ol
      {...props}
      dataSlot={props.dataSlot->Option.getOr("breadcrumb-list")}
      className={cn(
        "cn-breadcrumb-list flex flex-wrap items-center wrap-break-word",
        props.className,
      )}
    />
}

module Item = {
  @react.componentWithProps(BaseUi.Types.DomProps.t)
  let make = (props: BaseUi.Types.DomProps.t) =>
    <li
      {...props}
      dataSlot={props.dataSlot->Option.getOr("breadcrumb-item")}
      className={cn("cn-breadcrumb-item inline-flex items-center", props.className)}
    />
}

module Link = {
  type state = {slot: string}
  let toDomProps: BaseUi.Types.BaseUIComponentProps.t => BaseUi.Types.DomProps.t = %raw(`({className, render, ...props}) => props`)

  @react.componentWithProps(BaseUi.Types.BaseUIComponentProps.t)
  let make = (props: BaseUi.Types.BaseUIComponentProps.t) => {
    BaseUi.Render.use({
      defaultTagName: "a",
      render: ?props.render,
      props: BaseUi.Render.mergeProps(
        {className: cn("cn-breadcrumb-link", props.className)},
        toDomProps(props),
      ),
      state: {slot: "breadcrumb-link"},
    })
  }
}

module Page = {
  @react.componentWithProps(BaseUi.Types.DomProps.t)
  let make = (props: BaseUi.Types.DomProps.t) =>
    <span
      {...props}
      ariaCurrent=#page
      ariaDisabled=true
      role="link"
      dataSlot={props.dataSlot->Option.getOr("breadcrumb-page")}
      className={cn("cn-breadcrumb-page", props.className)}
    />
}

module Separator = {
  @react.componentWithProps(BaseUi.Types.DomProps.t)
  let make = (props: BaseUi.Types.DomProps.t) => {
    let children = props.children
    let content = switch children {
    | Some(content) => content
    | None => <Icons.ChevronRight className="cn-rtl-flip" />
    }
    <li
      {...props}
      ariaHidden=true
      role="presentation"
      dataSlot={props.dataSlot->Option.getOr("breadcrumb-separator")}
      className={cn("cn-breadcrumb-separator", props.className)}
    >
      {content}
    </li>
  }
}

module Ellipsis = {
  @react.componentWithProps(BaseUi.Types.DomProps.t)
  let make = (props: BaseUi.Types.DomProps.t) =>
    <span
      {...props}
      ariaHidden=true
      role="presentation"
      dataSlot={props.dataSlot->Option.getOr("breadcrumb-ellipsis")}
      className={cn("cn-breadcrumb-ellipsis flex items-center justify-center", props.className)}
    >
      <Icons.MoreHorizontal />
      <span className="sr-only"> {"More"->React.string} </span>
    </span>
}
