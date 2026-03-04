@react.component
let make = () =>
  <Field.Group className="max-w-sm">
    <Field>
      <Field.Label htmlFor="block-start-input"> {"Input"->React.string} </Field.Label>
      <InputGroup className="h-auto">
        <InputGroup.Input id="block-start-input" placeholder="Enter your name" />
        <InputGroup.Addon align=BlockStart>
          <InputGroup.Text> {"Full Name"->React.string} </InputGroup.Text>
        </InputGroup.Addon>
      </InputGroup>
      <Field.Description> {"Header positioned above the input."->React.string} </Field.Description>
    </Field>
    <Field>
      <Field.Label htmlFor="block-start-textarea"> {"Textarea"->React.string} </Field.Label>
      <InputGroup>
        <InputGroup.Textarea
          id="block-start-textarea"
          placeholder="console.log('Hello, world!');"
          className="font-mono text-sm"
        />
        <InputGroup.Addon align=BlockStart>
          <Icons.FileCode className="text-muted-foreground" />
          <InputGroup.Text className="font-mono"> {"script.js"->React.string} </InputGroup.Text>
          <InputGroup.Button size=IconXs className="ml-auto">
            <Icons.Download />
            <span className="sr-only"> {"Copy"->React.string} </span>
          </InputGroup.Button>
        </InputGroup.Addon>
      </InputGroup>
      <Field.Description>
        {"Header positioned above the textarea."->React.string}
      </Field.Description>
    </Field>
  </Field.Group>
