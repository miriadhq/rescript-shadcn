@react.component
let make = () =>
  <div className="grid w-full max-w-sm gap-6">
    <ButtonGroup>
      <ButtonGroup.Text render={<Label htmlFor="url" />}>
        {"https://"->React.string}
      </ButtonGroup.Text>
      <InputGroup>
        <InputGroup.Input id="url" />
        <InputGroup.Addon align=InlineEnd>
          <Icons.ExternalLink />
        </InputGroup.Addon>
      </InputGroup>
      <ButtonGroup.Text> {".com"->React.string} </ButtonGroup.Text>
    </ButtonGroup>
  </div>
