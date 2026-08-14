@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <ToggleGroup variant=Outline defaultSelectedKeys={["all"]}>
    <ToggleGroup.Item id="all" ariaLabel="Toggle all"> {"All"->React.string} </ToggleGroup.Item>
    <ToggleGroup.Item id="missed" ariaLabel="Toggle missed">
      {"Missed"->React.string}
    </ToggleGroup.Item>
  </ToggleGroup>
