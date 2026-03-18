@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Field.Group>
    <Field>
      <Field.Label htmlFor="input-kbd-22"> {"Input Group with Kbd"->React.string} </Field.Label>
      <InputGroup>
        <InputGroup.Input id="input-kbd-22" />
        <InputGroup.Addon>
          <Kbd> {"⌘K"->React.string} </Kbd>
        </InputGroup.Addon>
      </InputGroup>
      <InputGroup>
        <InputGroup.Input id="input-kbd-23" />
        <InputGroup.Addon align=InlineEnd>
          <Kbd> {"⌘K"->React.string} </Kbd>
        </InputGroup.Addon>
      </InputGroup>
      <InputGroup>
        <InputGroup.Input id="input-search-apps-24" placeholder="Search for Apps..." />
        <InputGroup.Addon align=InlineEnd> {"Ask AI"->React.string} </InputGroup.Addon>
        <InputGroup.Addon align=InlineEnd>
          <Kbd> {"Tab"->React.string} </Kbd>
        </InputGroup.Addon>
      </InputGroup>
      <InputGroup>
        <InputGroup.Input id="input-search-type-25" placeholder="Type to search..." />
        <InputGroup.Addon align=InlineStart>
          <Icons.Sparkles />
        </InputGroup.Addon>
        <InputGroup.Addon align=InlineEnd>
          <Kbd.Group>
            <Kbd> {"Ctrl"->React.string} </Kbd>
            <Kbd> {"C"->React.string} </Kbd>
          </Kbd.Group>
        </InputGroup.Addon>
      </InputGroup>
    </Field>
    <Field>
      <Field.Label htmlFor="input-username-26"> {"Username"->React.string} </Field.Label>
      <InputGroup>
        <InputGroup.Input id="input-username-26" defaultValue="shadcn" />
        <InputGroup.Addon align=InlineEnd>
          <div
            className="flex size-4 items-center justify-center rounded-full bg-green-500 dark:bg-green-800"
          >
            <Icons.Check className="size-3 text-white" />
          </div>
        </InputGroup.Addon>
      </InputGroup>
      <Field.Description className="text-green-700">
        {"This username is available."->React.string}
      </Field.Description>
    </Field>
    <InputGroup>
      <InputGroup.Input id="input-search-docs-27" placeholder="Search documentation..." />
      <InputGroup.Addon>
        <Icons.Search />
      </InputGroup.Addon>
      <InputGroup.Addon align=InlineEnd> {"12 results"->React.string} </InputGroup.Addon>
    </InputGroup>
    <InputGroup dataDisabled={true}>
      <InputGroup.Input
        id="input-search-disabled-28" placeholder="Search documentation..." disabled={true}
      />
      <InputGroup.Addon>
        <Icons.Search />
      </InputGroup.Addon>
      <InputGroup.Addon align=InlineEnd> {"Disabled"->React.string} </InputGroup.Addon>
    </InputGroup>
    <Field.Group className="grid grid-cols-2 gap-4">
      <Field>
        <Field.Label htmlFor="input-group-11"> {"First Name"->React.string} </Field.Label>
        <InputGroup>
          <InputGroup.Input id="input-group-11" placeholder="First Name" />
          <InputGroup.Addon align=InlineEnd>
            <Icons.Info />
          </InputGroup.Addon>
        </InputGroup>
      </Field>
      <Field>
        <Field.Label htmlFor="input-group-12"> {"Last Name"->React.string} </Field.Label>
        <InputGroup>
          <InputGroup.Input id="input-group-12" placeholder="Last Name" />
          <InputGroup.Addon align=InlineEnd>
            <Icons.Info />
          </InputGroup.Addon>
        </InputGroup>
      </Field>
    </Field.Group>
    <Field dataDisabled={true}>
      <Field.Label htmlFor="input-group-29">
        {"Loading (data-disabled=\"true\")"->React.string}
      </Field.Label>
      <InputGroup>
        <InputGroup.Input id="input-group-29" disabled={true} defaultValue="shadcn" />
        <InputGroup.Addon align=InlineEnd>
          <Spinner />
        </InputGroup.Addon>
      </InputGroup>
      <Field.Description>
        {"This is a description of the input group."->React.string}
      </Field.Description>
    </Field>
  </Field.Group>
