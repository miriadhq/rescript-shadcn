@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Field className="w-fit">
    <Field.Label htmlFor="digits-only"> {"Digits Only"->React.string} </Field.Label>
    <InputOtp id="digits-only" maxLength={6} pattern={InputOtp.regexpOnlyDigits}>
      <InputOtp.Group>
        <InputOtp.Slot index={0} />
        <InputOtp.Slot index={1} />
        <InputOtp.Slot index={2} />
        <InputOtp.Slot index={3} />
        <InputOtp.Slot index={4} />
        <InputOtp.Slot index={5} />
      </InputOtp.Group>
    </InputOtp>
  </Field>
