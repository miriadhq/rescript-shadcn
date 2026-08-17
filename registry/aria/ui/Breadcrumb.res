@@directive("'use client'")

@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

@react.componentWithProps(ReactAria.Types.DomProps.t)
let make = (props: ReactAria.Types.DomProps.t) =>
  <nav
    {...props}
    ariaLabel="breadcrumb"
    dataSlot="breadcrumb"
    className={cn("cn-breadcrumb", props.className)}
  />

module List = {
  type props<'item> = {...ReactAria.Breadcrumbs.props<'item>}

  @react.componentWithProps(props)
  let make = ({...ReactAria.Breadcrumbs.props as props}) =>
    <ReactAria.Breadcrumbs
      {...props}
      dataSlot="breadcrumb-list"
      className={cn(
        "cn-breadcrumb-list flex flex-wrap items-center wrap-break-word",
        props.className,
      )}
    />
}

module Item = {
  type props = {
    separatorClassName?: string,
    ...ReactAria.Breadcrumbs.Item.props,
  }
  @warning("-112") @react.componentWithProps(props)
  let make = ({?separatorClassName, ?children, ...ReactAria.Breadcrumbs.Item.props as props}) =>
    <ReactAria.Breadcrumbs.Item
      {...props}
      dataSlot="breadcrumb-item"
      className={cn("cn-breadcrumb-item inline-flex items-center", props.className)}
      children={ReactAria.Common.composeRenderElement(children, (
        children,
        {isCurrent}: ReactAria.Breadcrumbs.Item.RenderProps.t,
      ) =>
        <>
          {children}
          {isCurrent
            ? React.null
            : <span
                dataSlot="breadcrumb-separator"
                role="presentation"
                ariaHidden=true
                className={cn("cn-breadcrumb-separator", separatorClassName)}
              >
                <Icons.ChevronRight className="cn-rtl-flip" />
              </span>}
        </>
      )}
    />
}

module Link = {
  @react.componentWithProps(ReactAria.Button.Link.props)
  let make = (props: ReactAria.Button.Link.props) =>
    <ReactAria.Button.Link
      {...props} dataSlot="breadcrumb-link" className={cn("cn-breadcrumb-link", props.className)}
    />
}

module Page = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) =>
    <span
      {...props}
      dataSlot="breadcrumb-page"
      role="link"
      ariaDisabled=true
      ariaCurrent=#page
      className={cn("cn-breadcrumb-page", props.className)}
    />
}

module Ellipsis = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) =>
    <span
      {...props}
      dataSlot="breadcrumb-ellipsis"
      role="presentation"
      ariaHidden=true
      className={cn("cn-breadcrumb-ellipsis flex items-center justify-center", props.className)}
    >
      <Icons.MoreHorizontal />
      <span className="sr-only"> {"More"->React.string} </span>
    </span>
}
