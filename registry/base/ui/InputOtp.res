@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

@@directive("'use client'")

@module("cn")
external cn: (string, option<string>) => string = "cn"

module InputOtpPrimitive = {
  module Props = {
    type t = {
      size?: int,
      children?: Jsx.element,
      ...BaseUi.Types.BaseDomProps.t,
      ...BaseUi.Types.ExtraDomProps.t,
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
    char: nullable<string>,
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

@react.componentWithProps(InputOtpPrimitive.Props.t)
let make = (props: InputOtpPrimitive.Props.t) => {
  let containerClassName = props.containerClassName
  <InputOtpPrimitive
    {...props}
    dataSlot={props.dataSlot->Option.getOr("input-otp")}
    containerClassName={cn(
      "cn-input-otp flex items-center has-disabled:opacity-50",
      containerClassName,
    )}
    spellCheck={props.spellCheck->Option.getOr(false)}
    className={cn("cn-input-otp-input disabled:cursor-not-allowed", props.className)}
  />
}

module Group = {
  @react.componentWithProps(BaseUi.Types.DomProps.t)
  let make = (props: BaseUi.Types.DomProps.t) =>
    <div
      {...props}
      dataSlot={props.dataSlot->Option.getOr("input-otp-group")}
      className={cn("cn-input-otp-group flex items-center", props.className)}
    />
}

module Slot = {
  type props = {
    ...BaseUi.Types.DomProps.t,
    index: int,
  }

  let toBaseUiProps: props => BaseUi.Types.DomProps.t = %raw(`({index, ...props}) => props`)

  @react.componentWithProps(props)
  let make = (props: props) => {
    let index = props.index
    let children = props.children->Option.getOr(React.null)
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
      {...props->toBaseUiProps}
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
            {...props->toBaseUiProps}
            className="cn-input-otp-caret pointer-events-none absolute inset-0 flex items-center justify-center"
          >
            <div {...props->toBaseUiProps} className="cn-input-otp-caret-line" />
          </div>
        : React.null}
      {children}
    </div>
  }
}

module Separator = {
  @react.componentWithProps(BaseUi.Types.DomProps.t)
  let make = (props: BaseUi.Types.DomProps.t) => {
    let role = props.role->Option.getOr("separator")
    let dataSlot = props.dataSlot->Option.getOr("input-otp-separator")
    <div
      {...props}
      role
      dataSlot
      className={props.className->Option.getOr("cn-input-otp-separator flex items-center")}
    >
      <Icons.Minus />
      {props.children->Option.getOr(React.null)}
    </div>
  }
}

@module("input-otp") external regexpOnlyDigits: string = "REGEXP_ONLY_DIGITS"
@module("input-otp") external regexpOnlyDigitsAndChars: string = "REGEXP_ONLY_DIGITS_AND_CHARS"
