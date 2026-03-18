@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <RadioGroup defaultValue="plus" className="max-w-sm">
    <Field.Label htmlFor="plus-plan">
      <Field orientation=BaseUi.Types.Orientation.Horizontal>
        <Field.Content>
          <Field.Title> {"Plus"->React.string} </Field.Title>
          <Field.Description>
            {"For individuals and small teams."->React.string}
          </Field.Description>
        </Field.Content>
        <RadioGroup.Item value="plus" id="plus-plan" />
      </Field>
    </Field.Label>
    <Field.Label htmlFor="pro-plan">
      <Field orientation=BaseUi.Types.Orientation.Horizontal>
        <Field.Content>
          <Field.Title> {"Pro"->React.string} </Field.Title>
          <Field.Description> {"For growing businesses."->React.string} </Field.Description>
        </Field.Content>
        <RadioGroup.Item value="pro" id="pro-plan" />
      </Field>
    </Field.Label>
    <Field.Label htmlFor="enterprise-plan">
      <Field orientation=BaseUi.Types.Orientation.Horizontal>
        <Field.Content>
          <Field.Title> {"Enterprise"->React.string} </Field.Title>
          <Field.Description>
            {"For large teams and enterprises."->React.string}
          </Field.Description>
        </Field.Content>
        <RadioGroup.Item value="enterprise" id="enterprise-plan" />
      </Field>
    </Field.Label>
  </RadioGroup>
