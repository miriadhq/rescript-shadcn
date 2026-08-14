@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="grid w-full max-w-sm gap-4">
    <InputGroup>
      <InputGroup.Input id="email" placeholder="username" />
      <InputGroup.Addon>
        <Label htmlFor="email"> {"@"->React.string} </Label>
      </InputGroup.Addon>
    </InputGroup>
    <InputGroup>
      <InputGroup.Input id="email-2" placeholder="user@example.com" />
      <InputGroup.Addon align=BlockStart>
        <Label htmlFor="email-2" className="text-foreground"> {"Email"->React.string} </Label>
        <Tooltip.Trigger>
          <InputGroup.Button
            variant=Ghost ariaLabel="Help" className="ml-auto rounded-full" size=IconXs
          >
            <Icons.Info />
          </InputGroup.Button>
          <Tooltip>
            <p> {"We'll use this to send you notifications"->React.string} </p>
          </Tooltip>
        </Tooltip.Trigger>
      </InputGroup.Addon>
    </InputGroup>
  </div>
