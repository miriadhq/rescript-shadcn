@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

open BaseUi.Types

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

module DataOrientation = {
  @unboxed
  type t =
    | @as("horizontal") Horizontal
    | @as("vertical") Vertical
}

let buttonGroupVariants = (~orientation=DataOrientation.Horizontal) => {
  let base = "flex w-fit items-stretch *:focus-visible:relative *:focus-visible:z-10 has-[>[data-slot=button-group]]:gap-2 has-[select[aria-hidden=true]:last-child]:[&>[data-slot=select-trigger]:last-of-type]:rounded-r-lg [&>[data-slot=select-trigger]:not([class*='w-'])]:w-fit [&>input]:flex-1"
  let orientationClass = switch orientation {
  | Horizontal => "*:data-slot:rounded-r-none [&>[data-slot]:not(:has(~[data-slot]))]:rounded-r-lg! [&>[data-slot]~[data-slot]]:rounded-l-none [&>[data-slot]~[data-slot]]:border-l-0"
  | Vertical => "flex-col *:data-slot:rounded-b-none [&>[data-slot]:not(:has(~[data-slot]))]:rounded-b-lg! [&>[data-slot]~[data-slot]]:rounded-t-none [&>[data-slot]~[data-slot]]:border-t-0"
  }
  cn(base, Some(orientationClass))
}

@react.component
let make = (
  ~className=?,
  ~children=?,
  ~id=?,
  ~style=?,
  ~onClick=?,
  ~onKeyDown=?,
  ~ariaLabel=?,
  ~orientation=?,
) => {
  <div
    ?id
    ?style
    ?onClick
    ?onKeyDown
    ?ariaLabel
    ?children
    role="group"
    dataOrientation=?{(orientation :> option<string>)}
    dataSlot="button-group"
    className={cn(buttonGroupVariants(~orientation?), className)}
  />
}

module Text = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?, ~render=?) => {
    let props: BaseUi.Types.BaseUIComponentProps.t<string, bool> = {
      ?id,
      ?style,
      ?onClick,
      ?onKeyDown,
      ?children,
      dataSlot: "button-group-text",
      className: cn(
        "flex items-center gap-2 rounded-lg border bg-muted px-2.5 text-sm font-medium [&_svg]:pointer-events-none [&_svg:not([class*='size-'])]:size-4",
        className,
      ),
    }
    BaseUi.Render.use({defaultTagName: "div", props, ?render})
  }
}

module Separator = {
  @react.component
  let make = (~className=?, ~id=?, ~style=?, ~orientation=Orientation.Vertical, ~children=?) =>
    <BaseUi.Separator
      ?id
      ?style
      ?children
      dataSlot="button-group-separator"
      orientation
      className={cn(
        "relative self-stretch bg-input data-horizontal:mx-px data-horizontal:w-auto data-vertical:my-px data-vertical:h-auto",
        className,
      )}
    />
}
