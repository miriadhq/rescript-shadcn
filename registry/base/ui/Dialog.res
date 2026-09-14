@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

@@directive("'use client'")

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

@react.componentWithProps(BaseUi.Dialog.Root.props)
let make = (props: BaseUi.Dialog.Root.props<'payload>) =>
  <BaseUi.Dialog.Root {...props} dataSlot={props.dataSlot->Option.getOr("dialog")} />

module WithPayload = {
  @react.componentWithProps(BaseUi.Dialog.Root.WithPayload.props)
  let make = (props: BaseUi.Dialog.Root.WithPayload.props<'payload>) =>
    <BaseUi.Dialog.Root.WithPayload {...props} dataSlot={props.dataSlot->Option.getOr("dialog")} />
}

module Trigger = {
  @react.componentWithProps(BaseUi.Dialog.Trigger.props)
  let make = (props: BaseUi.Dialog.Trigger.props<'payload>) =>
    <BaseUi.Dialog.Trigger {...props} dataSlot={props.dataSlot->Option.getOr("dialog-trigger")} />
}

module Portal = {
  @react.component
  let make = (~children=?, ~container=?) =>
    <BaseUi.Dialog.Portal ?children ?container dataSlot="dialog-portal" />
}

module Close = {
  @react.componentWithProps(BaseUi.Dialog.Close.props)
  let make = (props: BaseUi.Dialog.Close.props) =>
    <BaseUi.Dialog.Close {...props} dataSlot={props.dataSlot->Option.getOr("dialog-close")} />
}

module Overlay = {
  @react.componentWithProps(BaseUi.Types.BaseUIComponentProps.t)
  let make = (props: BaseUi.Types.BaseUIComponentProps.t) =>
    <BaseUi.Dialog.Backdrop
      {...props}
      dataSlot={props.dataSlot->Option.getOr("dialog-overlay")}
      className={cn("cn-dialog-overlay fixed inset-0 isolate z-50", props.className)}
    />
}

module Content = {
  type props = {
    ...BaseUi.Types.BaseUIComponentProps.t,
    showCloseButton?: bool,
  }
  let toBaseUIComponentProps: props => BaseUi.Types.BaseUIComponentProps.t = %raw(`({showCloseButton, ...props}) => props`)
  @react.componentWithProps(props)
  let make = (props: props) =>
    <Portal>
      <Overlay />
      <BaseUi.Dialog.Popup
        {...props->toBaseUIComponentProps}
        dataSlot="dialog-content"
        className={cn(
          "cn-dialog-content bg-background data-open:animate-in data-closed:animate-out data-closed:fade-out-0 data-open:fade-in-0 data-closed:zoom-out-95 data-open:zoom-in-95 ring-foreground/10 fixed top-1/2 left-1/2 z-50 grid w-full max-w-[calc(100%-2rem)] -translate-x-1/2 -translate-y-1/2 gap-4 rounded-xl p-4 text-sm ring-1 duration-100 outline-none sm:max-w-sm",
          props.className,
        )}
      >
        {props.children->Option.getOr(React.null)}
        {switch props.showCloseButton {
        | Some(false) => React.null
        | None | Some(true) =>
          <BaseUi.Dialog.Close
            dataSlot="dialog-close"
            render={<Button
              variant=Ghost size=IconSm className="cn-dialog-close" dataSlot="dialog-close"
            />}
          >
            <Icons.X />
            <span className="sr-only"> {"Close"->React.string} </span>
          </BaseUi.Dialog.Close>
        }}
      </BaseUi.Dialog.Popup>
    </Portal>
}

module Header = {
  @react.componentWithProps(BaseUi.Types.DomProps.t)
  let make = (props: BaseUi.Types.DomProps.t) =>
    <div
      {...props}
      dataSlot={props.dataSlot->Option.getOr("dialog-header")}
      className={cn("cn-dialog-header flex flex-col", props.className)}
    />
}

module Footer = {
  type props = {
    ...BaseUi.Types.DomProps.t,
    showCloseButton?: bool,
  }
  let toDomProps: props => BaseUi.Types.DomProps.t = %raw(`({showCloseButton, ...props}) => props`)
  @react.componentWithProps(props)
  let make = (props: props) =>
    <div
      {...props->toDomProps}
      dataSlot={props.dataSlot->Option.getOr("dialog-footer")}
      className={cn(
        "cn-dialog-header cn-dialog-footer flex flex-col-reverse sm:flex-row sm:justify-end",
        props.className,
      )}
    >
      {props.children->Option.getOr(React.null)}
      {switch props.showCloseButton {
      | Some(true) =>
        <BaseUi.Dialog.Close render={<Button variant=Outline />}>
          {"Close"->React.string}
        </BaseUi.Dialog.Close>
      | Some(false) | None => React.null
      }}
    </div>
}

module Title = {
  @react.componentWithProps(BaseUi.Types.BaseUIComponentProps.t)
  let make = (props: BaseUi.Types.BaseUIComponentProps.t) =>
    <BaseUi.Dialog.Title
      {...props}
      dataSlot={props.dataSlot->Option.getOr("dialog-title")}
      className={cn("cn-dialog-title cn-font-heading", props.className)}
    />
}

module Description = {
  @react.componentWithProps(BaseUi.Types.BaseUIComponentProps.t)
  let make = (props: BaseUi.Types.BaseUIComponentProps.t) =>
    <BaseUi.Dialog.Description
      {...props}
      dataSlot={props.dataSlot->Option.getOr("dialog-description")}
      className={cn("cn-dialog-description", props.className)}
    />
}
