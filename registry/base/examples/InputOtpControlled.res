@@directive("'use client'")

@react.component
let make = () => {
  let (value, setValue) = React.useState(() => "")

  <div className="space-y-2">
    <InputOtp maxLength={6} value={value} onChange={v => setValue(_ => v)}>
      <InputOtp.Group>
        <InputOtp.Slot index={0} />
        <InputOtp.Slot index={1} />
        <InputOtp.Slot index={2} />
        <InputOtp.Slot index={3} />
        <InputOtp.Slot index={4} />
        <InputOtp.Slot index={5} />
      </InputOtp.Group>
    </InputOtp>
    <div className="text-center text-sm">
      {if value === "" {
        "Enter your one-time password."->React.string
      } else {
        {`You entered: ${value}`->React.string}
      }}
    </div>
  </div>
}
