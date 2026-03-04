@react.component
let make = () =>
  <ToggleGroup
    size=ToggleGroup.Size.Sm defaultValue={["top"]} variant=ToggleGroup.Variant.Outline spacing=2.
  >
    <ToggleGroup.Item value="top" ariaLabel="Toggle top"> {"Top"->React.string} </ToggleGroup.Item>
    <ToggleGroup.Item value="bottom" ariaLabel="Toggle bottom">
      {"Bottom"->React.string}
    </ToggleGroup.Item>
    <ToggleGroup.Item value="left" ariaLabel="Toggle left">
      {"Left"->React.string}
    </ToggleGroup.Item>
    <ToggleGroup.Item value="right" ariaLabel="Toggle right">
      {"Right"->React.string}
    </ToggleGroup.Item>
  </ToggleGroup>
