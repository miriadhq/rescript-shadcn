@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

@module("cn")
external cn: (string, option<string>) => string = "cn"

module Size = {
  @unboxed
  type t =
    | @as("icon") Icon
    | @as("default") Default
}

@react.componentWithProps(BaseUi.Types.DomProps.t)
let make = (props: BaseUi.Types.DomProps.t) => {
  let role = props.role->Option.getOr("navigation")
  <nav
    {...props}
    dataSlot={props.dataSlot->Option.getOr("pagination")}
    role
    ariaLabel={props.ariaLabel->Option.getOr("pagination")}
    className={cn("cn-pagination mx-auto flex w-full justify-center", props.className)}
  />
}

module Content = {
  @react.componentWithProps(BaseUi.Types.DomProps.t)
  let make = (props: BaseUi.Types.DomProps.t) =>
    <ul
      {...props}
      dataSlot={props.dataSlot->Option.getOr("pagination-content")}
      className={cn("cn-pagination-content flex items-center", props.className)}
    />
}

module Item = {
  @react.componentWithProps(BaseUi.Types.DomProps.t)
  let make = (props: BaseUi.Types.DomProps.t) =>
    <li {...props} dataSlot={props.dataSlot->Option.getOr("pagination-item")} />
}

module Link = {
  type props = {
    ...BaseUi.Types.BaseDomProps.t,
    ...BaseUi.Types.ExtraDomProps.t,
    children?: React.element,
    isActive?: bool,
    size?: Size.t,
  }

  let toBaseUiProps: props => BaseUi.Types.DomProps.t = %raw(`({className, children, isActive, size, ...props}) => props`)

  @react.componentWithProps(props)
  let make = (props: props) => {
    let isActive = props.isActive->Option.getOr(false)
    let size = props.size->Option.getOr(Size.Icon)
    let children = props.children
    <Button
      variant={isActive ? Outline : Ghost}
      size={(size :> Button.Size.t)}
      className={cn("cn-pagination-link", props.className)}
      nativeButton={false}
      render={<a
        {...props->toBaseUiProps}
        ariaCurrent=?{props.ariaCurrent->Option.orElse(isActive ? Some(#page) : None)}
        dataSlot={props.dataSlot->Option.getOr("pagination-link")}
        dataActive=?{props.dataActive->Option.orElse(isActive ? Some(true) : None)}
      />}
      ?children
    />
  }
}

module Previous = {
  type props = {
    ...Link.props,
    text?: string,
  }

  let toBaseUiProps: props => Link.props = %raw(`({text, ...props}) => props`)

  @react.componentWithProps(props)
  let make = (props: props) => {
    let text = props.text->Option.getOr("Previous")
    <Link
      {...props->toBaseUiProps}
      ariaLabel={props.ariaLabel->Option.getOr("Go to previous page")}
      size={props.size->Option.getOr(Size.Default)}
      className={cn("cn-pagination-previous", props.className)}
    >
      <Icons.ChevronLeft dataIcon="inline-start" className="cn-rtl-flip" />
      <span className="cn-pagination-previous-text hidden sm:block"> {text->React.string} </span>
    </Link>
  }
}

module Next = {
  type props = {
    ...Link.props,
    text?: string,
  }

  let toBaseUiProps: props => Link.props = %raw(`({text, ...props}) => props`)

  @react.componentWithProps(props)
  let make = (props: props) => {
    let text = props.text->Option.getOr("Next")
    <Link
      {...props->toBaseUiProps}
      ariaLabel={props.ariaLabel->Option.getOr("Go to next page")}
      size={props.size->Option.getOr(Size.Default)}
      className={cn("cn-pagination-next", props.className)}
    >
      <span className="cn-pagination-next-text hidden sm:block"> {text->React.string} </span>
      <Icons.ChevronRight dataIcon="inline-end" className="cn-rtl-flip" />
    </Link>
  }
}

module Ellipsis = {
  @react.componentWithProps(BaseUi.Types.DomProps.t)
  let make = (props: BaseUi.Types.DomProps.t) => {
    let ariaHidden = props.ariaHidden->Option.getOr(true)
    <span
      {...props}
      dataSlot={props.dataSlot->Option.getOr("pagination-ellipsis")}
      ariaHidden
      className={cn("cn-pagination-ellipsis flex items-center justify-center", props.className)}
    >
      <Icons.MoreHorizontal />
      <span className="sr-only"> {"More pages"->React.string} </span>
    </span>
  }
}
