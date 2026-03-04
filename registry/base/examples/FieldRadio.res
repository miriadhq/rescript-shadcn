@react.component
let make = () =>
  <Field.Set className="w-full max-w-xs">
    <Field.Legend variant=Label> {"Subscription Plan"->React.string} </Field.Legend>
    <Field.Description>
      {"Yearly and lifetime plans offer significant savings."->React.string}
    </Field.Description>
    <RadioGroup defaultValue="monthly">
      <Field orientation=BaseUi.Types.Orientation.Horizontal>
        <RadioGroup.Item value="monthly" id="plan-monthly" />
        <Field.Label htmlFor="plan-monthly" className="font-normal">
          {"Monthly ($9.99/month)"->React.string}
        </Field.Label>
      </Field>
      <Field orientation=BaseUi.Types.Orientation.Horizontal>
        <RadioGroup.Item value="yearly" id="plan-yearly" />
        <Field.Label htmlFor="plan-yearly" className="font-normal">
          {"Yearly ($99.99/year)"->React.string}
        </Field.Label>
      </Field>
      <Field orientation=BaseUi.Types.Orientation.Horizontal>
        <RadioGroup.Item value="lifetime" id="plan-lifetime" />
        <Field.Label htmlFor="plan-lifetime" className="font-normal">
          {"Lifetime ($299.99)"->React.string}
        </Field.Label>
      </Field>
    </RadioGroup>
  </Field.Set>
