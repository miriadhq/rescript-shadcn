@@directive("'use client'")

@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

module Side = {
  @unboxed
  type t =
    | @as("top") Top
    | @as("right") Right
    | @as("bottom") Bottom
    | @as("left") Left
}

module Trigger = {
  @react.componentWithProps(ReactAria.Dialog.Trigger.props)
  let make = (props: ReactAria.Dialog.Trigger.props) =>
    <ReactAria.Dialog.Trigger {...props} dataSlot="sheet-trigger" />
}

module Close = {
  @react.componentWithProps(Button.props)
  let make = (props: Button.props) => {
    let variant = props.variant->Option.getOr(Outline)
    let size = props.size->Option.getOr(Default)
    <Button
      {...props}
      slot="close"
      dataSlot="sheet-close"
      variant
      size
      className={cn("", props.className)}
    />
  }
}

type props = {
  side?: Side.t,
  showCloseButton?: bool,
  ...ReactAria.Dialog.Modal.props,
}

let overlayProps: props => ReactAria.Dialog.Modal.props = %raw(
  `({side, showCloseButton, className, children, ...props}) => props`
)

let renderSheet = (props: props) => {
  let side = props.side->Option.getOr(Side.Right)
  let showCloseButton = props.showCloseButton->Option.getOr(true)
  let isDismissable = props.isDismissable->Option.getOr(true)
  <ReactAria.Dialog.ModalOverlay
    {...props->overlayProps}
    isDismissable
    dataSlot="sheet-overlay"
    className="cn-sheet-overlay fixed inset-0 z-50 transition-opacity duration-150 data-entering:opacity-0 data-exiting:opacity-0"
  >
    <ReactAria.Dialog.Modal
      dataSlot="sheet-content"
      dataSide={(side :> string)}
      className={cn(
        "cn-sheet-content data-entering:opacity-0 data-exiting:opacity-0 data-[side=bottom]:data-entering:translate-y-[2.5rem] data-[side=bottom]:data-exiting:translate-y-[2.5rem] data-[side=left]:data-entering:translate-x-[-2.5rem] data-[side=left]:data-exiting:translate-x-[-2.5rem] data-[side=right]:data-entering:translate-x-[2.5rem] data-[side=right]:data-exiting:translate-x-[2.5rem] data-[side=top]:data-entering:translate-y-[-2.5rem] data-[side=top]:data-exiting:translate-y-[-2.5rem]",
        props.className,
      )}
    >
      <ReactAria.Dialog
        dataSlot="sheet"
        className="[display:inherit] h-full max-h-[inherit] [flex-direction:inherit] [gap:inherit] outline-none"
      >
        {props.children->Option.getOr(React.null)}
        {showCloseButton
          ? <Close variant=Ghost className="cn-sheet-close" size=IconSm>
              <Icons.X />
              <span className="sr-only"> {"Close"->React.string} </span>
            </Close>
          : React.null}
      </ReactAria.Dialog>
    </ReactAria.Dialog.Modal>
  </ReactAria.Dialog.ModalOverlay>
}

@react.componentWithProps(props)
let make = (props: props) => renderSheet(props)

module Content = {
  @react.componentWithProps(props)
  let make = (props: props) => renderSheet(props)
}

module Header = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) =>
    <div
      {...props}
      dataSlot="sheet-header"
      className={cn("cn-sheet-header flex flex-col", props.className)}
    />
}

module Footer = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) =>
    <div
      {...props}
      dataSlot="sheet-footer"
      className={cn("cn-sheet-footer mt-auto flex flex-col", props.className)}
    />
}

module Title = {
  @react.componentWithProps(ReactAria.Heading.props)
  let make = (props: ReactAria.Heading.props) =>
    <ReactAria.Heading
      {...props}
      slot="title"
      dataSlot="sheet-title"
      className={cn("cn-sheet-title cn-font-heading", props.className)}
    />
}

module Description = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) =>
    <div
      {...props}
      dataSlot="sheet-description"
      className={cn("cn-sheet-description", props.className)}
    />
}
