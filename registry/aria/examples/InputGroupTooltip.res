@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="grid w-full max-w-sm gap-4">
    <InputGroup>
      <InputGroup.Input placeholder="Enter password" type_="password" />
      <InputGroup.Addon align=InlineEnd>
        <Tooltip.Trigger>
          <InputGroup.Button variant=Ghost ariaLabel="Info" size=IconXs>
            <Icons.Info />
          </InputGroup.Button>
          <Tooltip>
            <p> {"Password must be at least 8 characters"->React.string} </p>
          </Tooltip>
        </Tooltip.Trigger>
      </InputGroup.Addon>
    </InputGroup>
    <InputGroup>
      <InputGroup.Input placeholder="Your email address" />
      <InputGroup.Addon align=InlineEnd>
        <Tooltip.Trigger>
          <InputGroup.Button variant=Ghost ariaLabel="Help" size=IconXs>
            <Icons.HelpCircle />
          </InputGroup.Button>
          <Tooltip>
            <p> {"We'll use this to send you notifications"->React.string} </p>
          </Tooltip>
        </Tooltip.Trigger>
      </InputGroup.Addon>
    </InputGroup>
    <InputGroup>
      <InputGroup.Input placeholder="Enter API key" />
      <Tooltip.Trigger>
        <InputGroup.Addon>
          <InputGroup.Button variant=Ghost ariaLabel="Help" size=IconXs>
            <Icons.HelpCircle />
          </InputGroup.Button>
        </InputGroup.Addon>
        <Tooltip placement=ReactAria.Common.Placement.Left>
          <p> {"Click for help with API keys"->React.string} </p>
        </Tooltip>
      </Tooltip.Trigger>
    </InputGroup>
  </div>
