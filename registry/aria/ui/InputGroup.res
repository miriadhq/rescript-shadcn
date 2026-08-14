@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

@@directive("'use client'")

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

@module("tailwind-merge")
external cn3: (string, string, option<string>) => string = "twMerge"

module Align = {
  @unboxed
  type t =
    | @as("inline-start") InlineStart
    | @as("inline-end") InlineEnd
    | @as("block-start") BlockStart
    | @as("block-end") BlockEnd
}

module Size = {
  @unboxed
  type t =
    | @as("xs") Xs
    | @as("sm") Sm
    | @as("icon-xs") IconXs
    | @as("icon-sm") IconSm
}

module Variant = {
  @unboxed
  type t =
    | @as("ghost") Ghost
    | @as("default") Default
    | @as("secondary") Secondary
    | @as("outline") Outline
    | @as("destructive") Destructive
}

@get external mouseEventTarget: JsxEvent.Mouse.t => Dom.element = "target"
@get external mouseEventCurrentTarget: JsxEvent.Mouse.t => Dom.element = "currentTarget"
@get external parentElement: Dom.element => nullable<Dom.element> = "parentElement"
@send external closest: (Dom.element, string) => nullable<Dom.element> = "closest"
@send external querySelector: (Dom.element, string) => nullable<Dom.element> = "querySelector"
@send external focusElement: Dom.element => unit = "focus"

@react.componentWithProps(ReactAria.Group.props)
let make = (props: ReactAria.Group.props) => {
  <ReactAria.Group
    {...props}
    dataSlot="input-group"
    className={cn(
      "group/input-group cn-input-group relative flex w-full min-w-0 items-center outline-none has-[>textarea]:h-auto",
      props.className,
    )}
  />
}

module Addon = {
  let baseClass = "cn-input-group-addon flex cursor-text items-center justify-center select-none"

  let alignClass = (~align=Align.InlineStart) =>
    switch align {
    | InlineStart => "cn-input-group-addon-align-inline-start order-first"
    | InlineEnd => "cn-input-group-addon-align-inline-end order-last"
    | BlockStart => "cn-input-group-addon-align-block-start order-first w-full justify-start"
    | BlockEnd => "cn-input-group-addon-align-block-end order-last w-full justify-start"
    }

  type props = {align?: Align.t, ...ReactAria.Types.DomProps.t}
  let domProps: props => ReactAria.Types.DomProps.t = %raw(`({align, ...props}) => props`)

  @react.componentWithProps(props)
  let make = (props: props) => {
    let align = props.align->Option.getOr(Align.InlineStart)
    let onClick = props.onClick->Option.getOr(event => {
      let target = event->mouseEventTarget
      switch target->closest("button") {
      | Value(_) => ()
      | Null | Undefined =>
        event
        ->mouseEventCurrentTarget
        ->parentElement
        ->Nullable.flatMap(parent => parent->querySelector("input"))
        ->Nullable.forEach(focusElement)
      }
    })
    <div
      {...props->domProps}
      onClick
      dataSlot="input-group-addon"
      dataAlign={(align :> string)}
      role="group"
      className={cn3(baseClass, alignClass(~align), props.className)}
    />
  }
}

module Button = {
  let sizeClass = (~size: Size.t) =>
    switch size {
    | Xs => "cn-input-group-button-size-xs"
    | Sm => "cn-input-group-button-size-sm"
    | IconXs => "cn-input-group-button-size-icon-xs"
    | IconSm => "cn-input-group-button-size-icon-sm"
    }

  let baseClass = "cn-input-group-button flex items-center shadow-none"

  type props = {
    variant?: Button.Variant.t,
    size?: Size.t,
    ...ReactAria.Button.props,
  }

  let toButtonProps: props => Button.props = %raw(`props => {
    const {variant, size, ...rest} = props;
    return rest;
  }`)

  @react.componentWithProps(props)
  let make = (props: props) => {
    let size = props.size->Option.getOr(Xs)
    let variant = props.variant->Option.getOr(Button.Variant.Ghost)
    <Button
      {...props->toButtonProps}
      type_={props.type_->Option.getOr("button")}
      variant
      size={(size :> Button.Size.t)}
      dataSize={(size :> string)}
      className={cn3(baseClass, sizeClass(~size), props.className)}
    />
  }
}

module Text = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) =>
    <span
      {...props}
      className={cn(
        "cn-input-group-text flex items-center [&_svg]:pointer-events-none",
        props.className,
      )}
    />
}

module Input = {
  @react.componentWithProps(ReactAria.Input.props)
  let make = (props: ReactAria.Input.props) =>
    <ReactAria.Input
      {...props}
      dataSlot="input-group-control"
      className={cn3(
        "cn-input w-full min-w-0 outline-none file:inline-flex file:border-0 file:bg-transparent file:text-foreground placeholder:text-muted-foreground disabled:pointer-events-none disabled:cursor-not-allowed disabled:opacity-50",
        "cn-input-group-input flex-1",
        props.className,
      )}
    />
}

module Textarea = {
  @react.componentWithProps(ReactAria.Input.props)
  let make = (props: ReactAria.Input.props) =>
    <Textarea
      {...props}
      dataSlot="input-group-control"
      className={cn(
        "cn-input-group-textarea flex-1 resize-none",
        props.className,
      )}
    />
}
