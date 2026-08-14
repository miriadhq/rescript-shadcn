@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

module Size = {
  @unboxed
  type t =
    | @as("icon") Icon
    | @as("default") Default
}

@react.componentWithProps(ReactAria.Types.DomProps.t)
let make = (props: ReactAria.Types.DomProps.t) => {
  <nav
    {...props}
    dataSlot={props.dataSlot->Option.getOr("pagination")}
    role={props.role->Option.getOr("navigation")}
    ariaLabel={props.ariaLabel->Option.getOr("pagination")}
    className={cn("cn-pagination mx-auto flex w-full justify-center", props.className)}
  />
}

module Content = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) => {
    <ul
      {...props}
      dataSlot={props.dataSlot->Option.getOr("pagination-content")}
      className={cn("cn-pagination-content flex items-center", props.className)}
    />
  }
}

module Item = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) =>
    <li {...props} dataSlot={props.dataSlot->Option.getOr("pagination-item")} />
}

module Link = {
  type props = {
    isActive?: bool,
    size?: Size.t,
    ...ReactAria.Button.Link.props,
  }
  let buttonProps: props => Button.LinkButton.props = %raw(`({isActive, ...props}) => props`)

  @react.componentWithProps(props)
  let make = (props: props) => {
    let isActive = props.isActive->Option.getOr(false)
    let size = props.size->Option.getOr(Icon)
    <Button.LinkButton
      {...props->buttonProps}
      variant={isActive ? Outline : Ghost}
      size={(size :> Button.Size.t)}
      className={cn("cn-pagination-link", props.className)}
      ariaCurrent=?{isActive ? Some(#page) : None}
      dataSlot={props.dataSlot->Option.getOr("pagination-link")}
      dataActive=?{isActive ? Some(true) : None}
    />
  }
}

module Previous = {
  type props = {text?: string, ...Link.props}
  let linkProps: props => Link.props = %raw(`({text, ...props}) => props`)

  @react.componentWithProps(props)
  let make = (props: props) => {
    let text = props.text->Option.getOr("Previous")
    <Link
      {...props->linkProps}
      ariaLabel={props.ariaLabel->Option.getOr("Go to previous page")}
      size={Size.Default}
      className={cn("cn-pagination-previous", props.className)}
    >
      <Icons.ChevronLeft dataIcon="inline-start" className="cn-rtl-flip" />
      <span className="cn-pagination-previous-text hidden sm:block"> {text->React.string} </span>
    </Link>
  }
}

module Next = {
  type props = {text?: string, ...Link.props}
  let linkProps: props => Link.props = %raw(`({text, ...props}) => props`)

  @react.componentWithProps(props)
  let make = (props: props) => {
    let text = props.text->Option.getOr("Next")
    <Link
      {...props->linkProps}
      ariaLabel={props.ariaLabel->Option.getOr("Go to next page")}
      size={Size.Default}
      className={cn("cn-pagination-next", props.className)}
    >
      <span className="cn-pagination-next-text hidden sm:block"> {text->React.string} </span>
      <Icons.ChevronRight dataIcon="inline-end" className="cn-rtl-flip" />
    </Link>
  }
}

module Ellipsis = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) => {
    <span
      {...props}
      dataSlot={props.dataSlot->Option.getOr("pagination-ellipsis")}
      ariaHidden={props.ariaHidden->Option.getOr(true)}
      className={cn(
        "cn-pagination-ellipsis flex items-center justify-center",
        props.className,
      )}
    >
      <Icons.MoreHorizontal />
      <span className="sr-only"> {"More pages"->React.string} </span>
    </span>
  }
}
