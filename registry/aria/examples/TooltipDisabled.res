@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Tooltip.Trigger>
    <span className="inline-block w-fit">
      <Button variant=Outline isDisabled={true}> {"Disabled"->React.string} </Button>
    </span>
    <Tooltip>
      <p> {"This feature is currently unavailable"->React.string} </p>
    </Tooltip>
  </Tooltip.Trigger>
