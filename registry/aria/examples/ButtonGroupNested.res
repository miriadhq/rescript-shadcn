@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <ButtonGroup>
    <ButtonGroup>
      <Button variant=Outline size=Icon>
        <Icons.Plus />
      </Button>
    </ButtonGroup>
    <ButtonGroup>
      <InputGroup>
        <InputGroup.Input placeholder="Send a message..." />
        <Tooltip.Trigger>
          <InputGroup.Addon align=InlineEnd>
            <Icons.AudioLines />
          </InputGroup.Addon>
          <Tooltip> {"Voice Mode"->React.string} </Tooltip>
        </Tooltip.Trigger>
      </InputGroup>
    </ButtonGroup>
  </ButtonGroup>
