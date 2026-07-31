@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (value, setValue) = React.useState(() => "000000")

  <InputOtp maxLength={6} value={value} onChange={v => setValue(_ => v)}>
    <InputOtp.Group>
      <InputOtp.Slot index={0} ariaInvalid={#"true"} />
      <InputOtp.Slot index={1} ariaInvalid={#"true"} />
    </InputOtp.Group>
    <InputOtp.Separator />
    <InputOtp.Group>
      <InputOtp.Slot index={2} ariaInvalid={#"true"} />
      <InputOtp.Slot index={3} ariaInvalid={#"true"} />
    </InputOtp.Group>
    <InputOtp.Separator />
    <InputOtp.Group>
      <InputOtp.Slot index={4} ariaInvalid={#"true"} />
      <InputOtp.Slot index={5} ariaInvalid={#"true"} />
    </InputOtp.Group>
  </InputOtp>
}
