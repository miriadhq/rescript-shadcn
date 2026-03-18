@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Field orientation=BaseUi.Types.Orientation.Horizontal className="max-w-sm">
    <Field.Content>
      <Field.Label htmlFor="switch-focus-mode">
        {"Share across devices"->React.string}
      </Field.Label>
      <Field.Description>
        {"Focus is shared across devices, and turns off when you leave the app."->React.string}
      </Field.Description>
    </Field.Content>
    <Switch id="switch-focus-mode" />
  </Field>
