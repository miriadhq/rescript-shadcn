@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="grid w-full max-w-sm gap-4">
    <InputGroup>
      <InputGroup.Input placeholder="Enter password" type_="password" />
      <InputGroup.Addon align=InlineEnd>
        <Tooltip>
          <Tooltip.Trigger
            render={<InputGroup.Button
              variant=InputGroup.Variant.Ghost ariaLabel="Info" size=InputGroup.Size.IconXs
            />}
          >
            <Icons.Info />
          </Tooltip.Trigger>
          <Tooltip.Content>
            <p> {"Password must be at least 8 characters"->React.string} </p>
          </Tooltip.Content>
        </Tooltip>
      </InputGroup.Addon>
    </InputGroup>
    <InputGroup>
      <InputGroup.Input placeholder="Your email address" />
      <InputGroup.Addon align=InlineEnd>
        <Tooltip>
          <Tooltip.Trigger
            render={<InputGroup.Button
              variant=InputGroup.Variant.Ghost ariaLabel="Help" size=InputGroup.Size.IconXs
            />}
          >
            <Icons.HelpCircle />
          </Tooltip.Trigger>
          <Tooltip.Content>
            <p> {"We'll use this to send you notifications"->React.string} </p>
          </Tooltip.Content>
        </Tooltip>
      </InputGroup.Addon>
    </InputGroup>
  </div>
