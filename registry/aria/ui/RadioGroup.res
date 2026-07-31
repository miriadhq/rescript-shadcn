@@directive("'use client'")

@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

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
) => {
  let onChange = onValueChange->Option.map(callback => value => callback(value, %raw(`undefined`)))
  <ReactAria.RadioGroup
    ?id
    ?name
    ?value
    ?defaultValue
    ?onChange
    isDisabled=?disabled
    isRequired=?required
    isReadOnly=?readOnly
    ?onClick
    ?onKeyDown
    ?ariaLabel
    ?dir
    ?style
    ?children
    dataSlot="radio-group"
    className={cn("cn-radio-group w-full", className)}
  />
}

module Item = {
  @react.component
  let make = (
    ~className=?,
    ~children=React.null,
    ~id=?,
    ~value,
    ~disabled=?,
    ~ariaLabel=?,
    ~ariaInvalid=?,
    ~dir=?,
    ~style=?,
  ) =>
    <ReactAria.Radio
      ?id
      value
      isDisabled=?disabled
      ?ariaLabel
      ?ariaInvalid
      ?dir
      ?style
      dataSlot="radio-group-item"
      className={cn(
        "cn-radio-group-item cn-radio-group-item-aria group/radio-group-item peer relative aspect-square shrink-0 border outline-none after:absolute after:-inset-x-3 after:-inset-y-2 disabled:cursor-not-allowed disabled:opacity-50",
        className,
      )}
    >
      <span
        dataSlot="radio-group-indicator" className="cn-radio-group-indicator"
      >
        <span
          className="cn-radio-group-indicator-icon"
        />
      </span>
      {children}
    </ReactAria.Radio>
}
