@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <RadioGroup defaultValue="comfortable" className="w-fit">
    <Field orientation=BaseUi.Types.Orientation.Horizontal>
      <RadioGroup.Item value="default" id="desc-r1" />
      <Field.Content>
        <Field.Label htmlFor="desc-r1"> {"Default"->React.string} </Field.Label>
        <Field.Description>
          {"Standard spacing for most use cases."->React.string}
        </Field.Description>
      </Field.Content>
    </Field>
    <Field orientation=BaseUi.Types.Orientation.Horizontal>
      <RadioGroup.Item value="comfortable" id="desc-r2" />
      <Field.Content>
        <Field.Label htmlFor="desc-r2"> {"Comfortable"->React.string} </Field.Label>
        <Field.Description> {"More space between elements."->React.string} </Field.Description>
      </Field.Content>
    </Field>
    <Field orientation=BaseUi.Types.Orientation.Horizontal>
      <RadioGroup.Item value="compact" id="desc-r3" />
      <Field.Content>
        <Field.Label htmlFor="desc-r3"> {"Compact"->React.string} </Field.Label>
        <Field.Description>
          {"Minimal spacing for dense layouts."->React.string}
        </Field.Description>
      </Field.Content>
    </Field>
  </RadioGroup>
