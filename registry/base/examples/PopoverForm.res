@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  <Popover>
    <Popover.Trigger render={<Button variant=Outline />}>
      {"Open Popover"->React.string}
    </Popover.Trigger>
    <Popover.Content className="w-64" align=Start>
      <Popover.Header>
        <Popover.Title> {"Dimensions"->React.string} </Popover.Title>
        <Popover.Description>
          {"Set the dimensions for the layer."->React.string}
        </Popover.Description>
      </Popover.Header>
      <Field.Group className="gap-4">
        <Field orientation=Horizontal>
          <Field.Label htmlFor="width" className="w-1/2"> {"Width"->React.string} </Field.Label>
          <Input id="width" defaultValue="100%" />
        </Field>
        <Field orientation=Horizontal>
          <Field.Label htmlFor="height" className="w-1/2"> {"Height"->React.string} </Field.Label>
          <Input id="height" defaultValue="25px" />
        </Field>
      </Field.Group>
    </Popover.Content>
  </Popover>
}
