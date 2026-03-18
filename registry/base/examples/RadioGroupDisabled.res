@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <RadioGroup defaultValue="option2" className="w-fit">
    <Field orientation=BaseUi.Types.Orientation.Horizontal dataDisabled={true}>
      <RadioGroup.Item value="option1" id="disabled-1" disabled={true} />
      <Field.Label htmlFor="disabled-1" className="font-normal">
        {"Disabled"->React.string}
      </Field.Label>
    </Field>
    <Field orientation=BaseUi.Types.Orientation.Horizontal>
      <RadioGroup.Item value="option2" id="disabled-2" />
      <Field.Label htmlFor="disabled-2" className="font-normal">
        {"Option 2"->React.string}
      </Field.Label>
    </Field>
    <Field orientation=BaseUi.Types.Orientation.Horizontal>
      <RadioGroup.Item value="option3" id="disabled-3" />
      <Field.Label htmlFor="disabled-3" className="font-normal">
        {"Option 3"->React.string}
      </Field.Label>
    </Field>
  </RadioGroup>
