@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Field className="max-w-sm">
    <Field.Label htmlFor="inline-start-input"> {"Input"->React.string} </Field.Label>
    <InputGroup>
      <InputGroup.Input id="inline-start-input" placeholder="Search..." />
      <InputGroup.Addon align=InlineStart>
        <Icons.Search className="text-muted-foreground" />
      </InputGroup.Addon>
    </InputGroup>
    <Field.Description> {"Icon positioned at the start."->React.string} </Field.Description>
  </Field>
