@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Card className="w-full">
    <Card.Header>
      <Card.Title> {"Card with Input Group"->React.string} </Card.Title>
      <Card.Description> {"This is a card with an input group."->React.string} </Card.Description>
    </Card.Header>
    <Card.Content>
      <Field.Group>
        <Field>
          <Field.Label htmlFor="email-input"> {"Email Address"->React.string} </Field.Label>
          <InputGroup>
            <InputGroup.Input id="email-input" type_="email" placeholder="you@example.com" />
            <InputGroup.Addon align=InlineEnd>
              <Icons.Mail />
            </InputGroup.Addon>
          </InputGroup>
        </Field>
        <Field>
          <Field.Label htmlFor="website-input"> {"Website URL"->React.string} </Field.Label>
          <InputGroup>
            <InputGroup.Addon>
              <InputGroup.Text> {"https://"->React.string} </InputGroup.Text>
            </InputGroup.Addon>
            <InputGroup.Input id="website-input" placeholder="example.com" />
            <InputGroup.Addon align=InlineEnd>
              <Icons.ExternalLink />
            </InputGroup.Addon>
          </InputGroup>
        </Field>
        <Field>
          <Field.Label htmlFor="feedback-textarea">
            {"Feedback & Comments"->React.string}
          </Field.Label>
          <InputGroup>
            <InputGroup.Textarea
              id="feedback-textarea" placeholder="Share your thoughts..." className="min-h-[100px]"
            />
            <InputGroup.Addon align=BlockEnd>
              <InputGroup.Text> {"0/500 characters"->React.string} </InputGroup.Text>
            </InputGroup.Addon>
          </InputGroup>
        </Field>
      </Field.Group>
    </Card.Content>
    <Card.Footer className="justify-end gap-2">
      <Button variant=Outline> {"Cancel"->React.string} </Button>
      <Button> {"Submit"->React.string} </Button>
    </Card.Footer>
  </Card>
