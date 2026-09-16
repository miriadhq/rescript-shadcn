@@directive("'use client'")

@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

@module("cn")
external cn: (string, option<string>) => string = "cn"

@react.componentWithProps(ReactAria.Types.DomProps.t)
let make = (props: ReactAria.Types.DomProps.t) => {
  let ariaLabel = props.ariaLabel->Option.getOr("breadcrumb")
  let dataSlot = props.dataSlot->Option.getOr("breadcrumb")
  <nav {...props} ariaLabel dataSlot className={cn("cn-breadcrumb", props.className)} />
}
module List = {
  @react.componentWithProps(ReactAria.Breadcrumbs.props)
  let make = (props: ReactAria.Breadcrumbs.props<'item>) => {
    let dataSlot = props.dataSlot->Option.getOr("breadcrumb-list")
    <ReactAria.Breadcrumbs
      {...props}
      dataSlot
      className={cn(
        "cn-breadcrumb-list flex flex-wrap items-center wrap-break-word",
        props.className,
      )}
    />
  }
}

module Item = {
  type props<'children> = {
    separatorClassName?: string,
    children?: 'children,
    ...ReactAria.Breadcrumbs.Item.componentProps,
  }
  let itemProps: props<
    'children,
  > => ReactAria.Breadcrumbs.Item.componentProps = %raw(`({separatorClassName, children, ...props}) => props`)

  @react.componentWithProps(props)
  let make = (props: props<'children>) => {
    let dataSlot = props.dataSlot->Option.getOr("breadcrumb-item")
    <ReactAria.Breadcrumbs.Item
      {...props->itemProps->ReactAria.Breadcrumbs.Item.toProps}
      dataSlot
      className={cn("cn-breadcrumb-item inline-flex items-center", props.className)}
      children={ReactAria.Common.composeRenderProps(props.children, (
        children,
        {isCurrent}: ReactAria.Breadcrumbs.Item.renderProps,
      ) =>
        <>
          {children}
          {isCurrent
            ? React.null
            : <span
                dataSlot="breadcrumb-separator"
                role="presentation"
                ariaHidden=true
                className={cn("cn-breadcrumb-separator", props.separatorClassName)}
              >
                <Icons.ChevronRight className="cn-rtl-flip" />
              </span>}
        </>
      )}
    />
  }
}

module Link = {
  @react.componentWithProps(ReactAria.Button.Link.props)
  let make = (props: ReactAria.Button.Link.props) => {
    let dataSlot = props.dataSlot->Option.getOr("breadcrumb-link")
    <ReactAria.Button.Link
      {...props} dataSlot className={cn("cn-breadcrumb-link", props.className)}
    />
  }
}

module Page = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) => {
    let role = props.role->Option.getOr("link")
    let ariaDisabled = props.ariaDisabled->Option.getOr(true)
    let ariaCurrent = props.ariaCurrent->Option.getOr(#page)
    let dataSlot = props.dataSlot->Option.getOr("breadcrumb-page")
    <span
      {...props}
      dataSlot
      role
      ariaDisabled
      ariaCurrent
      className={cn("cn-breadcrumb-page", props.className)}
    />
  }
}

module Ellipsis = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) => {
    let role = props.role->Option.getOr("presentation")
    let ariaHidden = props.ariaHidden->Option.getOr(true)
    let dataSlot = props.dataSlot->Option.getOr("breadcrumb-ellipsis")
    <span
      {...props}
      dataSlot
      role
      ariaHidden
      className={cn("cn-breadcrumb-ellipsis flex items-center justify-center", props.className)}
    >
      <Icons.MoreHorizontal />
      <span className="sr-only"> {"More"->React.string} </span>
    </span>
  }
}
