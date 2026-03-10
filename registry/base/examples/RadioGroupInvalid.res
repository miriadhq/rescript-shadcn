@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Field.Set className="w-full max-w-xs">
    <Field.Legend variant=Field.Variant.Label>
      {"Notification Preferences"->React.string}
    </Field.Legend>
    <Field.Description>
      {"Choose how you want to receive notifications."->React.string}
    </Field.Description>
    <RadioGroup defaultValue="email">
      <Field orientation=BaseUi.Types.Orientation.Horizontal dataInvalid={true}>
        <RadioGroup.Item value="email" id="invalid-email" ariaInvalid={true} />
        <Field.Label htmlFor="invalid-email" className="font-normal">
          {"Email only"->React.string}
        </Field.Label>
      </Field>
      <Field orientation=BaseUi.Types.Orientation.Horizontal dataInvalid={true}>
        <RadioGroup.Item value="sms" id="invalid-sms" ariaInvalid={true} />
        <Field.Label htmlFor="invalid-sms" className="font-normal">
          {"SMS only"->React.string}
        </Field.Label>
      </Field>
      <Field orientation=BaseUi.Types.Orientation.Horizontal dataInvalid={true}>
        <RadioGroup.Item value="both" id="invalid-both" ariaInvalid={true} />
        <Field.Label htmlFor="invalid-both" className="font-normal">
          {"Both Email & SMS"->React.string}
        </Field.Label>
      </Field>
    </RadioGroup>
  </Field.Set>
