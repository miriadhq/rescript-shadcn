@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

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

@react.componentWithProps(BaseUi.Types.DomProps.t)
let make = (props: BaseUi.Types.DomProps.t) => {
  <div
    {...props}
    dataSlot="input-group"
    role="group"
    className={cn(
      "cn-input-group group/input-group relative flex w-full min-w-0 items-center outline-none has-[>textarea]:h-auto",
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

  @react.component
  let make = (
    ~align=Align.InlineStart,
    ~className=?,
    ~children=?,
    ~id=?,
    ~style=?,
    ~onKeyDown=?,
  ) => {
    <div
      ?id
      ?children
      ?style
      onClick={event => {
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
      }}
      ?onKeyDown
      dataSlot="input-group-addon"
      dataAlign={(align :> string)}
      role="group"
      className={cn3(baseClass, alignClass(~align), className)}
    />
  }
}

module Button = {
  type type_ =
    | @as("button") Button
    | @as("submit") Submit
    | @as("reset") Reset

  let sizeClass = (~size: Size.t) =>
    switch size {
    | Xs => "cn-input-group-button-size-xs"
    | Sm => "cn-input-group-button-size-sm"
    | IconXs => "cn-input-group-button-size-icon-xs"
    | IconSm => "cn-input-group-button-size-icon-sm"
    }

  let baseClass = "cn-input-group-button flex items-center shadow-none"

  @react.component
  let make = (
    ~className=?,
    ~children=?,
    ~type_=Button,
    ~dataSlot="button",
    ~size=Size.Xs,
    ~variant=Variant.Ghost,
    ~id=?,
    ~style=?,
    ~onClick=?,
    ~onKeyDown=?,
    ~disabled=?,
    ~dataActive=?,
    ~ariaPressed=?,
    ~ariaLabel=?,
    ~render=?,
    ~nativeButton=?,
  ) => {
    <Button
      ?id
      ?children
      ?style
      ?onClick
      ?onKeyDown
      ?disabled
      ?dataActive
      ?ariaPressed
      ?ariaLabel
      ?render
      ?nativeButton
      type_={(type_ :> string)}
      variant={(variant :> Button.Variant.t)}
      dataSlot
      dataSize={(size :> string)}
      className={cn3(baseClass, sizeClass(~size), className)}
    />
  }
}

module Text = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <span
      ?id
      ?children
      ?style
      ?onClick
      ?onKeyDown
      className={cn(
        "cn-input-group-text flex items-center [&_svg]:pointer-events-none",
        className,
      )}
    />
}

module Input = {
  @react.componentWithProps(BaseUi.Input.props)
  let make = (props: BaseUi.Input.props) =>
    <Input
      {...props}
      dataSlot="input-group-control"
      className={cn(
        "cn-input-group-input flex-1",
        props.className,
      )}
    />
}

module Textarea = {
  @react.component
  let make = (
    ~className=?,
    ~children=?,
    ~id=?,
    ~style=?,
    ~name=?,
    ~placeholder=?,
    ~value=?,
    ~defaultValue=?,
    ~disabled=?,
    ~readOnly=?,
    ~required=?,
    ~maxLength=?,
    ~spellCheck=?,
    ~onClick=?,
    ~onKeyDown=?,
  ) =>
    <Textarea
      ?id
      ?children
      ?style
      ?name
      ?placeholder
      ?value
      ?defaultValue
      ?disabled
      ?readOnly
      ?required
      ?maxLength
      ?spellCheck
      ?onClick
      ?onKeyDown
      dataSlot="input-group-control"
      className={cn(
        "cn-input-group-textarea flex-1 resize-none",
        className,
      )}
    />
}
