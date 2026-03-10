@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex w-full max-w-md flex-col gap-4">
    <InputGroup>
      <InputGroup.Input placeholder="Send a message..." disabled={true} />
      <InputGroup.Addon align=InlineEnd>
        <Spinner />
      </InputGroup.Addon>
    </InputGroup>
    <InputGroup>
      <InputGroup.Textarea placeholder="Send a message..." disabled={true} />
      <InputGroup.Addon align=BlockEnd>
        <Spinner />
        {"Validating..."->React.string}
        <InputGroup.Button className="ml-auto">
          <Icons.ArrowUp />
          <span className="sr-only"> {"Send"->React.string} </span>
        </InputGroup.Button>
      </InputGroup.Addon>
    </InputGroup>
  </div>
