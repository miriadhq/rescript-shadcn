@@directive("'use client'")

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

module Size = {
  @unboxed
  type t =
    | @as("default") Default
    | @as("sm") Sm
}

@react.component
let make = (
  ~className=?,
  ~id=?,
  ~name=?,
  ~checked=?,
  ~defaultChecked=?,
  ~onCheckedChange=?,
  ~disabled=?,
  ~required=?,
  ~readOnly=?,
  ~onClick=?,
  ~onKeyDown=?,
  ~tabIndex=0,
  ~ariaLabel=?,
  ~ariaInvalid=?,
  ~dir=?,
  ~style=?,
  ~render=?,
  ~size=Size.Default,
) => {
  <BaseUi.Switch.Root
    ?id
    ?name
    ?checked
    ?defaultChecked
    ?onCheckedChange
    ?disabled
    ?required
    ?readOnly
    ?onClick
    ?onKeyDown
    tabIndex
    ?ariaLabel
    ?ariaInvalid
    ?dir
    ?style
    ?render
    dataSlot="switch"
    dataSize={(size :> string)}
    className={cn(
      "cn-switch peer group/switch relative inline-flex items-center transition-all outline-none after:absolute after:-inset-x-3 after:-inset-y-2 data-disabled:cursor-not-allowed data-disabled:opacity-50",
      className,
    )}
  >
    <BaseUi.Switch.Thumb
      dataSlot="switch-thumb"
      className="cn-switch-thumb pointer-events-none block ring-0 transition-transform"
    />
  </BaseUi.Switch.Root>
}
