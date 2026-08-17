@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

@@directive("'use client'")

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

module InputOtpPrimitive = {
  module Slot = {
    type t = {
      isActive: bool,
      char: nullable<string>,
      placeholderChar: nullable<string>,
      hasFakeCaret: bool,
    }
  }

  module RenderProps = {
    type t = {
      slots: array<Slot.t>,
      isFocused: bool,
      isHovering: bool,
    }
  }

  module Props = {
    type t = {
      key?: string,
      ref?: ReactDOM.domRef,
      className?: string,
      id?: string,
      style?: ReactDOM.Style.t,
      dir?: string,
      name?: string,
      value?: string,
      defaultValue?: string,
      placeholder?: string,
      maxLength: int,
      disabled?: bool,
      required?: bool,
      readOnly?: bool,
      tabIndex?: int,
      pattern?: string,
      spellCheck?: bool,
      autoComplete?: string,
      inputMode?: string,
      textAlign?: string,
      containerClassName?: string,
      onChange?: string => unit,
      onComplete?: string => unit,
      pasteTransformer?: string => string,
      pushPasswordManagerStrategy?: string,
      noScriptCSSFallback?: nullable<string>,
      render?: RenderProps.t => React.element,
      children?: React.element,
      onClick?: JsxEvent.Mouse.t => unit,
      onKeyDown?: JsxEvent.Keyboard.t => unit,
      @as("aria-label") ariaLabel?: string,
      @as("data-slot") dataSlot?: string,
    }
  }
  @module("input-otp")
  external make: React.component<Props.t> = "OTPInput"

  @module("input-otp") @val
  external context: React.Context.t<RenderProps.t> = "OTPInputContext"
}

@react.componentWithProps(InputOtpPrimitive.Props.t)
let make = (props: InputOtpPrimitive.Props.t) => {
  <InputOtpPrimitive
    {...props}
    dataSlot={props.dataSlot->Option.getOr("input-otp")}
    containerClassName={cn(
      "cn-input-otp flex items-center has-disabled:opacity-50",
      props.containerClassName,
    )}
    spellCheck={props.spellCheck->Option.getOr(false)}
    className={cn("cn-input-otp-input disabled:cursor-not-allowed", props.className)}
  />
}

module Group = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) =>
    <div
      {...props}
      dataSlot={props.dataSlot->Option.getOr("input-otp-group")}
      className={cn("cn-input-otp-group flex items-center", props.className)}
    />
}

module Slot = {
  type props = {index: int, ...ReactAria.Types.DomProps.t}

  @react.componentWithProps(props)
  let make = ({index, ...ReactAria.Types.DomProps.t as props}) => {
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
      {...props}
      dataSlot={props.dataSlot->Option.getOr("input-otp-slot")}
      dataActive={isActive}
      className={cn(
        "cn-input-otp-slot relative flex items-center justify-center data-[active=true]:z-10",
        props.className,
      )}
    >
      {char}
      {hasFakeCaret
        ? <div
            className="cn-input-otp-caret pointer-events-none absolute inset-0 flex items-center justify-center"
          >
            <div className="cn-input-otp-caret-line" />
          </div>
        : React.null}
    </div>
  }
}

module Separator = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) =>
    <div
      {...props}
      role={props.role->Option.getOr("separator")}
      dataSlot={props.dataSlot->Option.getOr("input-otp-separator")}
      className={props.className->Option.getOr("cn-input-otp-separator flex items-center")}
    >
      <Icons.Minus />
    </div>
}

@module("input-otp") external regexpOnlyDigits: string = "REGEXP_ONLY_DIGITS"
@module("input-otp") external regexpOnlyDigitsAndChars: string = "REGEXP_ONLY_DIGITS_AND_CHARS"
