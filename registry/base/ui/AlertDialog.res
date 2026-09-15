@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

@@directive("'use client'")

module Variant = Button.Variant
module Size = Button.Size

@module("cn")
external cn: (string, option<string>) => string = "cn"

@react.componentWithProps(BaseUi.AlertDialog.Root.props)
let make = (props: BaseUi.AlertDialog.Root.props<'payload>) =>
  <BaseUi.AlertDialog.Root {...props} dataSlot={props.dataSlot->Option.getOr("alert-dialog")} />

module Trigger = {
  @react.componentWithProps(BaseUi.Dialog.Trigger.props)
  let make = (props: BaseUi.Dialog.Trigger.props<'payload>) =>
    <BaseUi.AlertDialog.Trigger
      {...props} dataSlot={props.dataSlot->Option.getOr("alert-dialog-trigger")}
    />
}

module Portal = {
  @react.componentWithProps(BaseUi.Dialog.Portal.props)
  let make = (props: BaseUi.Dialog.Portal.props) =>
    <BaseUi.AlertDialog.Portal
      {...props} dataSlot={props.dataSlot->Option.getOr("alert-dialog-portal")}
    />
}

module Overlay = {
  @react.componentWithProps(BaseUi.Types.BaseUIComponentProps.t)
  let make = (props: BaseUi.Types.BaseUIComponentProps.t) =>
    <BaseUi.AlertDialog.Backdrop
      {...props}
      dataSlot={props.dataSlot->Option.getOr("alert-dialog-overlay")}
      className={cn("cn-alert-dialog-overlay fixed inset-0 isolate z-50", props.className)}
    />
}

module Content = {
  module Size = {
    @unboxed
    type t =
      | @as("default") Default
      | @as("sm") Sm
  }
  type props = {
    ...BaseUi.Types.BaseUIComponentProps.t,
    size?: Size.t,
  }

  let toBaseUiProps: props => BaseUi.Types.BaseUIComponentProps.t = %raw(`({size, ...props}) => props`)

  @react.componentWithProps(props)
  let make = (props: props) => {
    let size = props.size->Option.getOr(Size.Default)
    <Portal>
      <Overlay />
      <BaseUi.AlertDialog.Popup
        {...props->toBaseUiProps}
        dataSlot={props.dataSlot->Option.getOr("alert-dialog-content")}
        dataSize={props.dataSize->Option.getOr((size :> string))}
        className={cn(
          "cn-alert-dialog-content data-open:animate-in data-closed:animate-out data-closed:fade-out-0 data-open:fade-in-0 data-closed:zoom-out-95 data-open:zoom-in-95 bg-background ring-foreground/10 group/alert-dialog-content fixed top-1/2 left-1/2 z-50 grid w-full -translate-x-1/2 -translate-y-1/2 gap-4 rounded-xl p-4 ring-1 duration-100 outline-none data-[size=default]:max-w-xs data-[size=sm]:max-w-xs data-[size=default]:sm:max-w-sm",
          props.className,
        )}
      />
    </Portal>
  }
}

module Header = {
  @react.componentWithProps(BaseUi.Types.DomProps.t)
  let make = (props: BaseUi.Types.DomProps.t) =>
    <div
      {...props}
      dataSlot={props.dataSlot->Option.getOr("alert-dialog-header")}
      className={cn("cn-alert-dialog-header", props.className)}
    />
}

module Footer = {
  @react.componentWithProps(BaseUi.Types.DomProps.t)
  let make = (props: BaseUi.Types.DomProps.t) =>
    <div
      {...props}
      dataSlot={props.dataSlot->Option.getOr("alert-dialog-footer")}
      className={cn(
        "cn-alert-dialog-footer flex flex-col-reverse gap-2 group-data-[size=sm]/alert-dialog-content:grid group-data-[size=sm]/alert-dialog-content:grid-cols-2 sm:flex-row sm:justify-end",
        props.className,
      )}
    />
}

module Media = {
  @react.componentWithProps(BaseUi.Types.DomProps.t)
  let make = (props: BaseUi.Types.DomProps.t) =>
    <div
      {...props}
      dataSlot={props.dataSlot->Option.getOr("alert-dialog-media")}
      className={cn("cn-alert-dialog-media", props.className)}
    />
}

module Title = {
  @react.componentWithProps(BaseUi.Types.BaseUIComponentProps.t)
  let make = (props: BaseUi.Types.BaseUIComponentProps.t) =>
    <BaseUi.AlertDialog.Title
      {...props}
      dataSlot={props.dataSlot->Option.getOr("alert-dialog-title")}
      className={cn("cn-alert-dialog-title cn-font-heading", props.className)}
    />
}

module Description = {
  @react.componentWithProps(BaseUi.Types.BaseUIComponentProps.t)
  let make = (props: BaseUi.Types.BaseUIComponentProps.t) =>
    <BaseUi.AlertDialog.Description
      {...props}
      dataSlot={props.dataSlot->Option.getOr("alert-dialog-description")}
      className={cn("cn-alert-dialog-description", props.className)}
    />
}

module Action = {
  @react.componentWithProps(Button.props)
  let make = (props: Button.props) => {
    let className = props.className->Option.getOr("")
    let variant = props.variant->Option.getOr(Variant.Default)
    let size = props.size->Option.getOr(Size.Default)
    <Button
      {...props}
      className={cn("cn-alert-dialog-action", Some(className))}
      variant
      size
      dataSlot={props.dataSlot->Option.getOr("alert-dialog-action")}
    />
  }
}

module Cancel = {
  type props = {
    ...BaseUi.Dialog.Close.props,
    variant?: Variant.t,
    size?: Size.t,
  }

  let toBaseUiProps: props => BaseUi.Dialog.Close.props = %raw(`({variant, size, className, ...props}) => props`)

  @react.componentWithProps(props)
  let make = (props: props) => {
    let className = props.className->Option.getOr("")
    let variant = props.variant->Option.getOr(Variant.Outline)
    let size = props.size->Option.getOr(Size.Default)
    let render =
      props.render->Option.getOr(
        <Button variant size className={cn("cn-alert-dialog-cancel", Some(className))} />,
      )
    <BaseUi.AlertDialog.Close
      {...props->toBaseUiProps}
      dataSlot={props.dataSlot->Option.getOr("alert-dialog-cancel")}
      render
    />
  }
}
