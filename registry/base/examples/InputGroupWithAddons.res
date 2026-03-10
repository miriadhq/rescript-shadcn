@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Field.Group>
    <Field>
      <Field.Label htmlFor="input-icon-left-05">
        {"Addon (inline-start)"->React.string}
      </Field.Label>
      <InputGroup>
        <InputGroup.Input id="input-icon-left-05" />
        <InputGroup.Addon>
          <Icons.Search className="text-muted-foreground" />
        </InputGroup.Addon>
      </InputGroup>
    </Field>
    <Field>
      <Field.Label htmlFor="input-icon-right-07">
        {"Addon (inline-end)"->React.string}
      </Field.Label>
      <InputGroup>
        <InputGroup.Input id="input-icon-right-07" />
        <InputGroup.Addon align=InlineEnd>
          <Icons.Eye />
        </InputGroup.Addon>
      </InputGroup>
    </Field>
    <Field>
      <Field.Label htmlFor="input-icon-both-09">
        {"Addon (inline-start and inline-end)"->React.string}
      </Field.Label>
      <InputGroup>
        <InputGroup.Input id="input-icon-both-09" />
        <InputGroup.Addon>
          <Icons.Search className="text-muted-foreground" />
        </InputGroup.Addon>
        <InputGroup.Addon align=InlineEnd>
          <Icons.Info className="animate-pulse text-red-500" />
        </InputGroup.Addon>
      </InputGroup>
    </Field>
    <Field>
      <Field.Label htmlFor="input-addon-20"> {"Addon (block-start)"->React.string} </Field.Label>
      <InputGroup className="h-auto">
        <InputGroup.Input id="input-addon-20" />
        <InputGroup.Addon align=BlockStart>
          <InputGroup.Text> {"First Name"->React.string} </InputGroup.Text>
          <Icons.Info className="text-muted-foreground ml-auto" />
        </InputGroup.Addon>
      </InputGroup>
    </Field>
    <Field>
      <Field.Label htmlFor="input-addon-21"> {"Addon (block-end)"->React.string} </Field.Label>
      <InputGroup className="h-auto">
        <InputGroup.Input id="input-addon-21" />
        <InputGroup.Addon align=BlockEnd>
          <InputGroup.Text> {"20/240 characters"->React.string} </InputGroup.Text>
          <Icons.Info className="text-muted-foreground ml-auto" />
        </InputGroup.Addon>
      </InputGroup>
    </Field>
    <Field>
      <Field.Label htmlFor="input-icon-both-10"> {"Multiple Icons"->React.string} </Field.Label>
      <InputGroup>
        <InputGroup.Input id="input-icon-both-10" />
        <InputGroup.Addon align=InlineEnd>
          <Icons.Info />
          <InputGroup.Button size=InputGroup.Size.IconXs>
            <Icons.Download />
          </InputGroup.Button>
        </InputGroup.Addon>
        <InputGroup.Addon>
          <Icons.Info className="animate-pulse text-red-500" />
        </InputGroup.Addon>
      </InputGroup>
    </Field>
    <Field>
      <Field.Label htmlFor="input-description-10"> {"Description"->React.string} </Field.Label>
      <InputGroup>
        <InputGroup.Input id="input-description-10" />
        <InputGroup.Addon align=InlineEnd>
          <Icons.Info />
        </InputGroup.Addon>
      </InputGroup>
      <Field.Description>
        {"This is a description of the input group."->React.string}
      </Field.Description>
    </Field>
    <Field>
      <Field.Label htmlFor="input-label-10"> {"Label"->React.string} </Field.Label>
      <InputGroup>
        <InputGroup.Addon>
          <Field.Label htmlFor="input-label-10"> {"Label"->React.string} </Field.Label>
        </InputGroup.Addon>
        <InputGroup.Input id="input-label-10" />
      </InputGroup>
      <InputGroup>
        <InputGroup.Input id="input-optional-12" ariaLabel="Optional" />
        <InputGroup.Addon align=InlineEnd>
          <InputGroup.Text> {"(optional)"->React.string} </InputGroup.Text>
        </InputGroup.Addon>
      </InputGroup>
    </Field>
  </Field.Group>
