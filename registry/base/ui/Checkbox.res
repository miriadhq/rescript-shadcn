@@directive("'use client'")

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
  ~render=?,
) => {
  <BaseUi.Checkbox.Root
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
    ?tabIndex
    ?ariaLabel
    ?ariaInvalid
    ?dir
    ?style
    ?render
    dataSlot="checkbox"
    className={cn(
      "cn-checkbox peer relative shrink-0 outline-none after:absolute after:-inset-x-3 after:-inset-y-2 disabled:cursor-not-allowed disabled:opacity-50",
      className,
    )}
  >
    <BaseUi.Checkbox.Indicator
      dataSlot="checkbox-indicator"
      className="cn-checkbox-indicator grid place-content-center text-current transition-none"
    >
      <Icons.Check />
    </BaseUi.Checkbox.Indicator>
  </BaseUi.Checkbox.Root>
}
