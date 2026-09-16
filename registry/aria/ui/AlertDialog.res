@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

@@directive("'use client'")

@module("cn")
external cn: (string, option<string>) => string = "cn"

module Size = {
  @unboxed
  type t =
    | @as("default") Default
    | @as("sm") Sm
}

module Trigger = {
  @react.componentWithProps(ReactAria.Dialog.Trigger.props)
  let make = (props: ReactAria.Dialog.Trigger.props) => {
    let dataSlot = props.dataSlot->Option.getOr("alert-dialog-trigger")
    <ReactAria.Dialog.Trigger {...props} dataSlot />
  }
}

module Overlay = {
  @react.componentWithProps(ReactAria.Dialog.Modal.props)
  let make = (props: ReactAria.Dialog.Modal.props) => {
    let dataSlot = props.dataSlot->Option.getOr("alert-dialog-overlay")
    <ReactAria.Dialog.ModalOverlay
      {...props}
      dataSlot
      className={cn("cn-alert-dialog-overlay-aria fixed inset-0 isolate z-50", props.className)}
    />
  }
}

type props = {size?: Size.t, ...ReactAria.Dialog.Modal.props}
let overlayProps: props => ReactAria.Dialog.Modal.props = %raw(`({size, className, children, ...props}) => props`)

let render = (props: props) => {
  let size = props.size->Option.getOr(Size.Default)
  <Overlay {...props->overlayProps}>
    <ReactAria.Dialog.Modal
      dataSlot="alert-dialog-content"
      dataSize={(size :> string)}
      className={cn(
        "cn-alert-dialog-content-aria group/alert-dialog-content fixed top-1/2 left-1/2 z-50 grid w-full -translate-x-1/2 -translate-y-1/2 outline-none",
        props.className,
      )}
    >
      <ReactAria.Dialog
        dataSlot="alert-dialog"
        role="alertdialog"
        className="[display:inherit] [gap:inherit] outline-none"
      >
        {props.children->Option.getOr(React.null)}
      </ReactAria.Dialog>
    </ReactAria.Dialog.Modal>
  </Overlay>
}

@react.componentWithProps(props)
let make = (props: props) => render(props)

module Content = {
  @react.componentWithProps(props)
  let make = (props: props) => render(props)
}

module Header = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) => {
    let dataSlot = props.dataSlot->Option.getOr("alert-dialog-header")
    <div {...props} dataSlot className={cn("cn-alert-dialog-header", props.className)} />
  }
}

module Footer = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) => {
    let dataSlot = props.dataSlot->Option.getOr("alert-dialog-footer")
    <div
      {...props}
      dataSlot
      className={cn(
        "cn-alert-dialog-footer flex flex-col-reverse gap-2 group-data-[size=sm]/alert-dialog-content:grid group-data-[size=sm]/alert-dialog-content:grid-cols-2 sm:flex-row sm:justify-end",
        props.className,
      )}
    />
  }
}

module Media = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) => {
    let dataSlot = props.dataSlot->Option.getOr("alert-dialog-media")
    <div {...props} dataSlot className={cn("cn-alert-dialog-media", props.className)} />
  }
}

module Title = {
  @react.componentWithProps(ReactAria.Heading.props)
  let make = (props: ReactAria.Heading.props) => {
    let dataSlot = props.dataSlot->Option.getOr("alert-dialog-title")
    <ReactAria.Heading
      {...props}
      slot="title"
      dataSlot
      className={cn("cn-alert-dialog-title cn-font-heading", props.className)}
    />
  }
}

module Description = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) => {
    let dataSlot = props.dataSlot->Option.getOr("alert-dialog-description")
    <div {...props} dataSlot className={cn("cn-alert-dialog-description", props.className)} />
  }
}

module Action = {
  @react.componentWithProps(Button.props)
  let make = (props: Button.props) => {
    let dataSlot = props.dataSlot->Option.getOr("alert-dialog-action")
    <Button
      {...props} slot="close" dataSlot className={cn("cn-alert-dialog-action", props.className)}
    />
  }
}

module Cancel = {
  @react.componentWithProps(Button.props)
  let make = (props: Button.props) => {
    let dataSlot = props.dataSlot->Option.getOr("alert-dialog-cancel")
    let variant = props.variant->Option.getOr(Outline)
    let size = props.size->Option.getOr(Default)
    <Button
      {...props}
      variant
      size
      slot="close"
      dataSlot
      className={cn("cn-alert-dialog-cancel", props.className)}
    />
  }
}
