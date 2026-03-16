@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Card className="mx-auto max-w-md">
    <Card.Header>
      <Card.Title> {"Verify your login"->React.string} </Card.Title>
      <Card.Description>
        {"Enter the verification code we sent to your email address: "->React.string}
        <span className="font-medium"> {"m@example.com"->React.string} </span>
        {"."->React.string}
      </Card.Description>
    </Card.Header>
    <Card.Content>
      <Field>
        <div className="flex items-center justify-between">
          <Field.Label htmlFor="otp-verification">
            {"Verification code"->React.string}
          </Field.Label>
          <Button variant=Button.Variant.Outline size=Button.Size.Xs>
            <Icons.RefreshCw />
            {"Resend Code"->React.string}
          </Button>
        </div>
        <InputOtp maxLength={6} id="otp-verification" required={true}>
          <InputOtp.Group
            className="*:data-[slot=input-otp-slot]:h-12 *:data-[slot=input-otp-slot]:w-11 *:data-[slot=input-otp-slot]:text-xl"
          >
            <InputOtp.Slot index={0} />
            <InputOtp.Slot index={1} />
            <InputOtp.Slot index={2} />
          </InputOtp.Group>
          <InputOtp.Separator className="mx-2" />
          <InputOtp.Group
            className="*:data-[slot=input-otp-slot]:h-12 *:data-[slot=input-otp-slot]:w-11 *:data-[slot=input-otp-slot]:text-xl"
          >
            <InputOtp.Slot index={3} />
            <InputOtp.Slot index={4} />
            <InputOtp.Slot index={5} />
          </InputOtp.Group>
        </InputOtp>
        <Field.Description>
          <a href="#"> {"I no longer have access to this email address."->React.string} </a>
        </Field.Description>
      </Field>
    </Card.Content>
    <Card.Footer>
      <Field>
        <Button type_="submit" className="w-full"> {"Verify"->React.string} </Button>
        <div className="text-muted-foreground text-sm">
          {"Having trouble signing in? "->React.string}
          <a href="#" className="hover:text-primary underline underline-offset-4 transition-colors">
            {"Contact support"->React.string}
          </a>
        </div>
      </Field>
    </Card.Footer>
  </Card>
