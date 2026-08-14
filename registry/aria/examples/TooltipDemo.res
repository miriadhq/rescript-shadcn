@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Tooltip.Trigger>
    <Button variant=Outline> {"Hover"->React.string} </Button>
    <Tooltip>
      <p> {"Add to library"->React.string} </p>
    </Tooltip>
  </Tooltip.Trigger>
