@react.component
let make = () =>
  <ToggleGroup variant=ToggleGroup.Variant.Outline defaultValue={["all"]}>
    <ToggleGroup.Item value="all" ariaLabel="Toggle all"> {"All"->React.string} </ToggleGroup.Item>
    <ToggleGroup.Item value="missed" ariaLabel="Toggle missed">
      {"Missed"->React.string}
    </ToggleGroup.Item>
  </ToggleGroup>
