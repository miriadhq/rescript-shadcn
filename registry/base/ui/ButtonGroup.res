@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

open BaseUi.Types

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

let buttonGroupVariants = (~orientation=BaseUi.Types.Orientation.Horizontal) => {
  let base = "cn-button-group flex w-fit items-stretch *:focus-visible:relative *:focus-visible:z-10 [&>[data-slot=select-trigger]:not([class*='w-'])]:w-fit [&>input]:flex-1"
  let orientationClass = switch orientation {
  | Horizontal => "cn-button-group-orientation-horizontal *:data-slot:rounded-r-none [&>[data-slot]~[data-slot]]:rounded-l-none [&>[data-slot]~[data-slot]]:border-l-0"
  | Vertical => "cn-button-group-orientation-vertical flex-col *:data-slot:rounded-b-none [&>[data-slot]~[data-slot]]:rounded-t-none [&>[data-slot]~[data-slot]]:border-t-0"
  }
  cn(base, Some(orientationClass))
}

@react.componentWithProps(BaseUi.Types.DomProps.t)
let make = ({?role, ?orientation, ?dataSlot, ?className} as props: BaseUi.Types.DomProps.t) => {
  <div
    {...props}
    role={role->Option.getOr("group")}
    dataOrientation=?{(orientation :> option<string>)}
    dataSlot={dataSlot->Option.getOr("button-group")}
    className={cn(buttonGroupVariants(~orientation?), className)}
  />
}

module Text = {
  module State = {
    type t = {
      slot: string,
    }
  }
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?, ~render=?) => {
    let props: BaseUi.Types.BaseUIComponentProps.t = {
      ?id,
      ?style,
      ?onClick,
      ?onKeyDown,
      ?children,
      className: cn(
        "cn-button-group-text flex items-center [&_svg]:pointer-events-none",
        className,
      ),
    }
    BaseUi.Render.use({
      defaultTagName: "div",
      props,
      ?render,
      state: {State.slot: "button-group-text"},
    })
  }
}

module Separator = {
  @react.componentWithProps(BaseUIComponentProps.t)
  let make = (props: BaseUIComponentProps.t) =>
    <Separator
      {...props}
      dataSlot={props.dataSlot->Option.getOr("button-group-separator")}
      orientation={props.orientation->Option.getOr(Vertical)}
      className={cn(
        "cn-button-group-separator relative self-stretch data-horizontal:mx-px data-horizontal:w-auto data-vertical:my-px data-vertical:h-auto",
        props.className,
      )}
    />
}
