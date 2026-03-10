@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Field.Group className="w-full max-w-[10rem]">
    <Field orientation=BaseUi.Types.Orientation.Horizontal>
      <Switch id="switch-size-sm" size=Switch.Size.Sm />
      <Field.Label htmlFor="switch-size-sm"> {"Small"->React.string} </Field.Label>
    </Field>
    <Field orientation=BaseUi.Types.Orientation.Horizontal>
      <Switch id="switch-size-default" size=Switch.Size.Default />
      <Field.Label htmlFor="switch-size-default"> {"Default"->React.string} </Field.Label>
    </Field>
  </Field.Group>
