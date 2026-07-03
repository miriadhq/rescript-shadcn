@@directive("'use client'")

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

@react.component
let make = (
  ~className=?,
  ~children=?,
  ~id=?,
  ~name=?,
  ~value=?,
  ~defaultValue=?,
  ~onValueChange=?,
  ~disabled=?,
  ~required=?,
  ~readOnly=?,
  ~onClick=?,
  ~onKeyDown=?,
  ~ariaLabel=?,
  ~dir=?,
  ~style=?,
) =>
  <BaseUi.RadioGroup
    ?id
    ?name
    ?value
    ?defaultValue
    ?onValueChange
    ?disabled
    ?required
    ?readOnly
    ?onClick
    ?onKeyDown
    ?ariaLabel
    ?dir
    ?style
    ?children
    dataSlot="radio-group"
    className={cn("cn-radio-group w-full", className)}
  />

module Item = {
  @react.component
  let make = (
    ~className=?,
    ~children=React.null,
    ~id=?,
    ~name=?,
    ~value,
    ~disabled=?,
    ~required=?,
    ~readOnly=?,
    ~ariaLabel=?,
    ~ariaInvalid=?,
    ~dir=?,
    ~style=?,
    ~render=?,
    ~nativeButton=?,
  ) =>
    <BaseUi.Radio.Root
      ?id
      ?name
      value
      ?disabled
      ?required
      ?readOnly
      ?ariaLabel
      ?ariaInvalid
      ?render
      ?nativeButton
      ?dir
      ?style
      dataSlot="radio-group-item"
      className={cn(
        "cn-radio-group-item group/radio-group-item peer relative aspect-square shrink-0 border outline-none after:absolute after:-inset-x-3 after:-inset-y-2 disabled:cursor-not-allowed disabled:opacity-50",
        className,
      )}
    >
      <BaseUi.Radio.Indicator
        dataSlot="radio-group-indicator" className="cn-radio-group-indicator"
      >
        <span
          className="cn-radio-group-indicator-icon"
        />
      </BaseUi.Radio.Indicator>
      {children}
    </BaseUi.Radio.Root>
}
