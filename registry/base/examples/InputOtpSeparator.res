@react.component
let make = () =>
  <InputOtp maxLength={6}>
    <InputOtp.Group>
      <InputOtp.Slot index={0} />
      <InputOtp.Slot index={1} />
    </InputOtp.Group>
    <InputOtp.Separator />
    <InputOtp.Group>
      <InputOtp.Slot index={2} />
      <InputOtp.Slot index={3} />
    </InputOtp.Group>
    <InputOtp.Separator />
    <InputOtp.Group>
      <InputOtp.Slot index={4} />
      <InputOtp.Slot index={5} />
    </InputOtp.Group>
  </InputOtp>
