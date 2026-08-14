@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Field.Group>
    <Field>
      <Field.Label htmlFor="input-button-13"> {"Button"->React.string} </Field.Label>
      <InputGroup>
        <InputGroup.Input id="input-button-13" />
        <InputGroup.Addon>
          <InputGroup.Button> {"Default"->React.string} </InputGroup.Button>
        </InputGroup.Addon>
      </InputGroup>
      <InputGroup>
        <InputGroup.Input id="input-button-14" />
        <InputGroup.Addon>
          <InputGroup.Button variant=Outline> {"Outline"->React.string} </InputGroup.Button>
        </InputGroup.Addon>
      </InputGroup>
      <InputGroup>
        <InputGroup.Input id="input-button-15" />
        <InputGroup.Addon>
          <InputGroup.Button variant=Secondary> {"Secondary"->React.string} </InputGroup.Button>
        </InputGroup.Addon>
      </InputGroup>
      <InputGroup>
        <InputGroup.Input id="input-button-16" />
        <InputGroup.Addon align=InlineEnd>
          <InputGroup.Button variant=Secondary> {"Button"->React.string} </InputGroup.Button>
        </InputGroup.Addon>
      </InputGroup>
      <InputGroup>
        <InputGroup.Input id="input-button-17" />
        <InputGroup.Addon align=InlineEnd>
          <InputGroup.Button size=IconXs>
            <Icons.Copy />
          </InputGroup.Button>
        </InputGroup.Addon>
      </InputGroup>
      <InputGroup>
        <InputGroup.Input id="input-button-18" />
        <InputGroup.Addon align=InlineEnd>
          <InputGroup.Button variant=Secondary size=IconXs>
            <Icons.Trash />
          </InputGroup.Button>
        </InputGroup.Addon>
      </InputGroup>
    </Field>
  </Field.Group>
