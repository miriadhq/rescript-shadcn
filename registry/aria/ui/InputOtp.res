@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

@@directive("'use client'")

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

module InputOtpPrimitive = {
  module Props = {
    type t = {
      size?: int,
      ...ReactAria.Types.BaseDomProps.t,
      ...ReactAria.Types.ExtraDomProps.t,
      containerClassName?: string,
      onChange?: string => unit,
      value?: string,
      defaultValue?: string,
    }
  }
  @module("input-otp")
  external make: React.component<Props.t> = "OTPInput"

  type slot = {
    isActive: bool,
    char: Nullable.t<string>,
    hasFakeCaret: bool,
  }

  type renderProps = {
    slots: array<slot>,
    isFocused: bool,
    isHovering: bool,
  }

  @module("input-otp") @val
  external context: React.Context.t<renderProps> = "OTPInputContext"
}

@react.component
let make = (
  ~className=?,
  ~containerClassName=?,
  ~children=?,
  ~id=?,
  ~name=?,
  ~value=?,
  ~defaultValue=?,
  ~maxLength=?,
  ~disabled=?,
  ~required=?,
  ~readOnly=?,
  ~onChange=?,
  ~onClick=?,
  ~onKeyDown=?,
  ~tabIndex=?,
  ~ariaLabel=?,
  ~style=?,
  ~pattern=?,
  ~dir=?,
) => {
  <InputOtpPrimitive
    ?id
    ?name
    ?value
    ?defaultValue
    ?maxLength
    ?disabled
    ?required
    ?readOnly
    ?onClick
    ?onChange
    ?onKeyDown
    ?tabIndex
    ?ariaLabel
    ?style
    ?pattern
    ?dir
    ?children
    dataSlot="input-otp"
    containerClassName={cn(
      "cn-input-otp flex items-center has-disabled:opacity-50",
      containerClassName,
    )}
    spellCheck={false}
    className={cn("cn-input-otp-input disabled:cursor-not-allowed", className)}
  />
}

module Group = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <div
      ?id
      ?style
      ?onClick
      ?onKeyDown
      ?children
      dataSlot="input-otp-group"
      className={cn(
        "cn-input-otp-group flex items-center",
        className,
      )}
    />
}

module Slot = {
  @react.component
  let make = (
    ~index,
    ~className=?,
    ~children=React.null,
    ~id=?,
    ~style=?,
    ~onClick=?,
    ~onKeyDown=?,
    ~ariaInvalid=?,
  ) => {
    let inputOtpContext = React.useContext(InputOtpPrimitive.context)
    let (char, hasFakeCaret, isActive) = switch inputOtpContext.slots[index] {
    | Some(slot) => (
        slot.char->Nullable.map(React.string)->Nullable.getOr(React.null),
        slot.hasFakeCaret,
        slot.isActive,
      )
    | None => (React.null, false, false)
    }
    <div
      ?id
      ?style
      ?onClick
      ?onKeyDown
      ?ariaInvalid
      dataSlot="input-otp-slot"
      dataActive={isActive}
      className={cn(
        "cn-input-otp-slot relative flex items-center justify-center data-[active=true]:z-10",
        className,
      )}
    >
      {char}
      {hasFakeCaret
        ? <div className="cn-input-otp-caret pointer-events-none absolute inset-0 flex items-center justify-center">
            <div className="cn-input-otp-caret-line" />
          </div>
        : React.null}
      {children}
    </div>
  }
}

module Separator = {
  @react.component
  let make = (~className=?, ~children=React.null, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <div
      ?id
      ?style
      ?onClick
      ?onKeyDown
      role="separator"
      dataSlot="input-otp-separator"
      className={cn("cn-input-otp-separator flex items-center", className)}
    >
      <Icons.Minus />
      {children}
    </div>
}

@module("input-otp") external regexpOnlyDigits: string = "REGEXP_ONLY_DIGITS"
@module("input-otp") external regexpOnlyDigitsAndChars: string = "REGEXP_ONLY_DIGITS_AND_CHARS"
