@@directive("'use client'")

@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

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
  ~tabIndex=?,
  ~ariaLabel=?,
  ~ariaInvalid=?,
  ~dir=?,
  ~style=?,
) => {
  let onChange = onCheckedChange->Option.map(callback => checked => callback(checked, %raw(`undefined`)))
  <ReactAria.Checkbox
    ?id
    ?name
    isSelected=?checked
    defaultSelected=?defaultChecked
    ?onChange
    isDisabled=?disabled
    isRequired=?required
    isReadOnly=?readOnly
    ?onClick
    ?onKeyDown
    ?tabIndex
    ?ariaLabel
    ?ariaInvalid
    ?dir
    ?style
    dataSlot="checkbox"
    className={cn(
      "cn-checkbox cn-checkbox-aria peer relative shrink-0 outline-none after:absolute after:-inset-x-3 after:-inset-y-2 disabled:cursor-not-allowed disabled:opacity-50",
      className,
    )}
  >
    <span
      dataSlot="checkbox-indicator"
      className="cn-checkbox-indicator grid place-content-center text-current transition-none"
    >
      <Icons.Check />
    </span>
  </ReactAria.Checkbox>
}
