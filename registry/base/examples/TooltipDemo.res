@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Tooltip>
    <Tooltip.Trigger render={<Button variant=Button.Variant.Outline dataSlot="tooltip-trigger" />}>
      {"Hover"->React.string}
    </Tooltip.Trigger>
    <Tooltip.Content>
      <p> {"Add to library"->React.string} </p>
    </Tooltip.Content>
  </Tooltip>
