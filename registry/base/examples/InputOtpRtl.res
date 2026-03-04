@@directive("'use client'")

@react.component
let make = () =>
  <Field className="mx-auto max-w-xs">
    <Field.Label htmlFor="input-otp-rtl"> {"رمز التحقق"->React.string} </Field.Label>
    <InputOtp maxLength={6} defaultValue="123456" dir="rtl" id="input-otp-rtl">
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
