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
  @react.componentWithProps(ReactAria.Breadcrumbs.props)
  let make = (props: ReactAria.Breadcrumbs.props<'item>) =>
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
  type props<'children> = {
    separatorClassName?: string,
    children?: 'children,
    ...ReactAria.Breadcrumbs.Item.componentProps,
  }
  let itemProps: props<'children> => ReactAria.Breadcrumbs.Item.componentProps = %raw(
    `({separatorClassName, children, ...props}) => props`
  )

  @react.componentWithProps(props)
  let make = (props: props<'children>) =>
    <ReactAria.Breadcrumbs.Item
      {...props->itemProps->ReactAria.Breadcrumbs.Item.toProps}
      dataSlot="breadcrumb-item"
      className={cn("cn-breadcrumb-item inline-flex items-center", props.className)}
      children={ReactAria.Common.composeRenderProps(
        props.children,
        (children, {isCurrent}: ReactAria.Breadcrumbs.Item.renderProps) =>
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
        </>,
      )}
    />
}

module Link = {
  @react.componentWithProps(ReactAria.Button.Link.props)
  let make = (props: ReactAria.Button.Link.props) =>
    <ReactAria.Button.Link
      {...props}
      dataSlot="breadcrumb-link"
      className={cn("cn-breadcrumb-link", props.className)}
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
      className={cn(
        "cn-breadcrumb-ellipsis flex items-center justify-center",
        props.className,
      )}
    >
      <Icons.MoreHorizontal />
      <span className="sr-only"> {"More"->React.string} </span>
    </span>
}
