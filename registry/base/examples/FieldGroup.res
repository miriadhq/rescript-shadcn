@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Field.Group className="w-full max-w-xs">
    <Field.Set>
      <Field.Label> {"Responses"->React.string} </Field.Label>
      <Field.Description>
        {"Get notified when ChatGPT responds to requests that take time, like research or image generation."->React.string}
      </Field.Description>
      <Field.Group dataSlot="checkbox-group">
        <Field orientation=BaseUi.Types.Orientation.Horizontal>
          <Checkbox id="push" defaultChecked={true} disabled={true} />
          <Field.Label htmlFor="push" className="font-normal">
            {"Push notifications"->React.string}
          </Field.Label>
        </Field>
      </Field.Group>
    </Field.Set>
    <Field.Separator />
    <Field.Set>
      <Field.Label> {"Tasks"->React.string} </Field.Label>
      <Field.Description>
        {"Get notified when tasks you've created have updates. "->React.string}
        <a href="#"> {"Manage tasks"->React.string} </a>
      </Field.Description>
      <Field.Group dataSlot="checkbox-group">
        <Field orientation=BaseUi.Types.Orientation.Horizontal>
          <Checkbox id="push-tasks" />
          <Field.Label htmlFor="push-tasks" className="font-normal">
            {"Push notifications"->React.string}
          </Field.Label>
        </Field>
        <Field orientation=BaseUi.Types.Orientation.Horizontal>
          <Checkbox id="email-tasks" />
          <Field.Label htmlFor="email-tasks" className="font-normal">
            {"Email notifications"->React.string}
          </Field.Label>
        </Field>
      </Field.Group>
    </Field.Set>
  </Field.Group>
