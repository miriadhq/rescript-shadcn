@react.component
let make = () =>
  <div className="grid w-full max-w-sm gap-6">
    <InputGroup>
      <InputGroup.Addon>
        <InputGroup.Text> {"$"->React.string} </InputGroup.Text>
      </InputGroup.Addon>
      <InputGroup.Input placeholder="0.00" />
      <InputGroup.Addon align=InlineEnd>
        <InputGroup.Text> {"USD"->React.string} </InputGroup.Text>
      </InputGroup.Addon>
    </InputGroup>
    <InputGroup>
      <InputGroup.Addon>
        <InputGroup.Text> {"https://"->React.string} </InputGroup.Text>
      </InputGroup.Addon>
      <InputGroup.Input placeholder="example.com" className="!pl-0.5" />
      <InputGroup.Addon align=InlineEnd>
        <InputGroup.Text> {".com"->React.string} </InputGroup.Text>
      </InputGroup.Addon>
    </InputGroup>
    <InputGroup>
      <InputGroup.Input placeholder="Enter your username" />
      <InputGroup.Addon align=InlineEnd>
        <InputGroup.Text> {"@company.com"->React.string} </InputGroup.Text>
      </InputGroup.Addon>
    </InputGroup>
    <InputGroup>
      <InputGroup.Textarea placeholder="Enter your message" />
      <InputGroup.Addon align=BlockEnd>
        <InputGroup.Text className="text-muted-foreground text-xs">
          {"120 characters left"->React.string}
        </InputGroup.Text>
      </InputGroup.Addon>
    </InputGroup>
  </div>
