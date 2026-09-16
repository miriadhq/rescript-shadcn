@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

@@directive("'use client'")

@module("cn")
external cn: (string, option<string>) => string = "cn"

module Trigger = {
  @react.componentWithProps(ReactAria.Dialog.Trigger.props)
  let make = (props: ReactAria.Dialog.Trigger.props) => {
    let dataSlot = props.dataSlot->Option.getOr("dialog-trigger")
    <ReactAria.Dialog.Trigger {...props} dataSlot />
  }
}

module Close = {
  @react.componentWithProps(Button.props)
  let make = (props: Button.props) => {
    let dataSlot = props.dataSlot->Option.getOr("dialog-close")
    let variant = props.variant->Option.getOr(Outline)
    let size = props.size->Option.getOr(Default)
    <Button {...props} variant size slot="close" dataSlot className={cn("", props.className)} />
  }
}

module Overlay = {
  @react.componentWithProps(ReactAria.Dialog.Modal.props)
  let make = (props: ReactAria.Dialog.Modal.props) => {
    let dataSlot = props.dataSlot->Option.getOr("dialog-overlay")
    <ReactAria.Dialog.ModalOverlay
      {...props}
      dataSlot
      className={cn("cn-dialog-overlay-aria fixed inset-0 isolate z-50", props.className)}
    />
  }
}

type props = {showCloseButton?: bool, ...ReactAria.Dialog.Modal.props}
let overlayProps: props => ReactAria.Dialog.Modal.props = %raw(`({showCloseButton, className, children, ...props}) => props`)

@react.componentWithProps(props)
let make = (props: props) => {
  let showCloseButton = props.showCloseButton->Option.getOr(true)
  let isDismissable = props.isDismissable->Option.getOr(true)
  <Overlay {...props->overlayProps} isDismissable>
    <ReactAria.Dialog.Modal
      dataSlot="dialog-content"
      className={cn(
        "cn-dialog-content-aria fixed top-1/2 left-1/2 z-50 w-full -translate-x-1/2 -translate-y-1/2 outline-none",
        props.className,
      )}
    >
      <ReactAria.Dialog dataSlot="dialog" className="[display:inherit] [gap:inherit] outline-none">
        {props.children->Option.getOr(React.null)}
        {showCloseButton
          ? <Close variant=Ghost size=IconSm className="cn-dialog-close">
              <Icons.X />
              <span className="sr-only"> {"Close"->React.string} </span>
            </Close>
          : React.null}
      </ReactAria.Dialog>
    </ReactAria.Dialog.Modal>
  </Overlay>
}

module Header = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) => {
    let dataSlot = props.dataSlot->Option.getOr("dialog-header")
    <div {...props} dataSlot className={cn("cn-dialog-header flex flex-col", props.className)} />
  }
}

module Footer = {
  type props = {showCloseButton?: bool, ...ReactAria.Types.DomProps.t}
  let divProps: props => ReactAria.Types.DomProps.t = %raw(`({showCloseButton, ...props}) => props`)

  @react.componentWithProps(props)
  let make = (props: props) => {
    let dataSlot = props.dataSlot->Option.getOr("dialog-footer")
    <div
      {...props->divProps}
      dataSlot
      className={cn(
        "cn-dialog-footer flex flex-col-reverse gap-2 sm:flex-row sm:justify-end",
        props.className,
      )}
    >
      {props.children->Option.getOr(React.null)}
      {props.showCloseButton->Option.getOr(false)
        ? <Close variant=Outline> {"Close"->React.string} </Close>
        : React.null}
    </div>
  }
}

module Title = {
  @react.componentWithProps(ReactAria.Heading.props)
  let make = (props: ReactAria.Heading.props) => {
    let dataSlot = props.dataSlot->Option.getOr("dialog-title")
    <ReactAria.Heading
      {...props}
      slot="title"
      dataSlot
      className={cn("cn-dialog-title cn-font-heading", props.className)}
    />
  }
}

module Description = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) => {
    let dataSlot = props.dataSlot->Option.getOr("dialog-description")
    <div {...props} dataSlot className={cn("cn-dialog-description", props.className)} />
  }
}
