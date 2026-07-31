@@directive("'use client'")

@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

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
  ~size=Size.Default,
) => {
  let onChange = onCheckedChange->Option.map(callback => checked => callback(checked, %raw(`undefined`)))
  let isInvalid = switch ariaInvalid {
  | Some(#"true") => Some(true)
  | Some(_) => Some(false)
  | None => None
  }
  <ReactAria.Switch.Field
    ?id
    ?name
    isSelected=?checked
    defaultSelected=?defaultChecked
    ?onChange
    isDisabled=?disabled
    isRequired=?required
    isReadOnly=?readOnly
    ?isInvalid
    ?ariaInvalid
    ?dir
    className="contents"
  >
    <ReactAria.Switch.Button
      ?onClick
      ?onKeyDown
      tabIndex
      ?ariaLabel
      ?style
      dataSlot="switch"
      dataSize={(size :> string)}
      className={cn(
        "cn-switch cn-switch-aria peer group/switch relative inline-flex items-center transition-all outline-none after:absolute after:-inset-x-3 after:-inset-y-2 data-disabled:cursor-not-allowed data-disabled:opacity-50",
        className,
      )}
    >
      <span
        dataSlot="switch-thumb"
        className="cn-switch-thumb cn-switch-thumb-aria pointer-events-none block ring-0 transition-transform"
      />
    </ReactAria.Switch.Button>
  </ReactAria.Switch.Field>
}
