@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

@@directive("'use client'")

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

module Trigger = {
  @react.componentWithProps(ReactAria.Dialog.Trigger.props)
  let make = (props: ReactAria.Dialog.Trigger.props) =>
    <ReactAria.Dialog.Trigger {...props} dataSlot="dialog-trigger" />
}

module Close = {
  @react.componentWithProps(Button.props)
  let make = (props: Button.props) => {
    let variant = props.variant->Option.getOr(Outline)
    let size = props.size->Option.getOr(Default)
    <Button
      {...props}
      variant
      size
      slot="close"
      dataSlot="dialog-close"
      className={cn("", props.className)}
    />
  }
}

module Overlay = {
  @react.componentWithProps(ReactAria.Dialog.Modal.props)
  let make = (props: ReactAria.Dialog.Modal.props) =>
    <ReactAria.Dialog.ModalOverlay
      {...props}
      dataSlot="dialog-overlay"
      className={cn("cn-dialog-overlay-aria fixed inset-0 isolate z-50", props.className)}
    />
}

type props = {showCloseButton?: bool, ...ReactAria.Dialog.Modal.props}

@warning("-112") @react.componentWithProps(props)
let make = ({
  ?showCloseButton,
  ?className,
  ?children,
  ...ReactAria.Dialog.Modal.props as props,
}) => {
  let showCloseButton = showCloseButton->Option.getOr(true)
  let isDismissable = props.isDismissable->Option.getOr(true)
  <Overlay {...props} isDismissable>
    <ReactAria.Dialog.Modal
      dataSlot="dialog-content"
      className={cn(
        "cn-dialog-content-aria fixed top-1/2 left-1/2 z-50 w-full -translate-x-1/2 -translate-y-1/2 outline-none",
        className,
      )}
    >
      <ReactAria.Dialog dataSlot="dialog" className="[display:inherit] [gap:inherit] outline-none">
        {children->Option.getOr(React.null)}
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
  let make = (props: ReactAria.Types.DomProps.t) =>
    <div
      {...props}
      dataSlot="dialog-header"
      className={cn("cn-dialog-header flex flex-col", props.className)}
    />
}

module Footer = {
  type props = {showCloseButton?: bool, ...ReactAria.Types.DomProps.t}

  @react.componentWithProps(props)
  let make = ({?showCloseButton, ...ReactAria.Types.DomProps.t as props}) =>
    <div
      {...props}
      dataSlot="dialog-footer"
      className={cn(
        "cn-dialog-footer flex flex-col-reverse gap-2 sm:flex-row sm:justify-end",
        props.className,
      )}
    >
      {props.children->Option.getOr(React.null)}
      {showCloseButton->Option.getOr(false)
        ? <Close variant=Outline> {"Close"->React.string} </Close>
        : React.null}
    </div>
}

module Title = {
  @react.componentWithProps(ReactAria.Heading.props)
  let make = (props: ReactAria.Heading.props) =>
    <ReactAria.Heading
      {...props}
      slot="title"
      dataSlot="dialog-title"
      className={cn("cn-dialog-title cn-font-heading", props.className)}
    />
}

module Description = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) =>
    <div
      {...props}
      dataSlot="dialog-description"
      className={cn("cn-dialog-description", props.className)}
    />
}
