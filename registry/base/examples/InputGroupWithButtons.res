@react.component
let make = () =>
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
          <InputGroup.Button variant=InputGroup.Variant.Outline>
            {"Outline"->React.string}
          </InputGroup.Button>
        </InputGroup.Addon>
      </InputGroup>
      <InputGroup>
        <InputGroup.Input id="input-button-15" />
        <InputGroup.Addon>
          <InputGroup.Button variant=InputGroup.Variant.Secondary>
            {"Secondary"->React.string}
          </InputGroup.Button>
        </InputGroup.Addon>
      </InputGroup>
      <InputGroup>
        <InputGroup.Input id="input-button-16" />
        <InputGroup.Addon align=InlineEnd>
          <InputGroup.Button variant=InputGroup.Variant.Secondary>
            {"Button"->React.string}
          </InputGroup.Button>
        </InputGroup.Addon>
      </InputGroup>
      <InputGroup>
        <InputGroup.Input id="input-button-17" />
        <InputGroup.Addon align=InlineEnd>
          <InputGroup.Button size=InputGroup.Size.IconXs>
            <Icons.Download />
          </InputGroup.Button>
        </InputGroup.Addon>
      </InputGroup>
      <InputGroup>
        <InputGroup.Input id="input-button-18" />
        <InputGroup.Addon align=InlineEnd>
          <InputGroup.Button variant=InputGroup.Variant.Secondary size=InputGroup.Size.IconXs>
            <Icons.Trash />
          </InputGroup.Button>
        </InputGroup.Addon>
      </InputGroup>
    </Field>
  </Field.Group>
