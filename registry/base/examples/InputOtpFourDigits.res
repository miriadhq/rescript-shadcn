@react.component
let make = () =>
  <InputOtp maxLength={4} pattern={InputOtp.regexpOnlyDigits}>
    <InputOtp.Group>
      <InputOtp.Slot index={0} />
      <InputOtp.Slot index={1} />
      <InputOtp.Slot index={2} />
      <InputOtp.Slot index={3} />
    </InputOtp.Group>
  </InputOtp>
