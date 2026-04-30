@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Field.Group className="w-full max-w-sm">
    <Field.Label htmlFor="switch-share">
      <Field orientation=Horizontal>
        <Field.Content>
          <Field.Title> {"Share across devices"->React.string} </Field.Title>
          <Field.Description>
            {"Focus is shared across devices, and turns off when you leave the app."->React.string}
          </Field.Description>
        </Field.Content>
        <Switch id="switch-share" />
      </Field>
    </Field.Label>
    <Field.Label htmlFor="switch-notifications">
      <Field orientation=Horizontal>
        <Field.Content>
          <Field.Title> {"Enable notifications"->React.string} </Field.Title>
          <Field.Description>
            {"Receive notifications when focus mode is enabled or disabled."->React.string}
          </Field.Description>
        </Field.Content>
        <Switch id="switch-notifications" defaultChecked={true} />
      </Field>
    </Field.Label>
  </Field.Group>
