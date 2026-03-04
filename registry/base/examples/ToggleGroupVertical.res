@react.component
let make = () =>
  <ToggleGroup
    multiple=true
    orientation=ToggleGroup.Orientation.Vertical
    spacing=1.
    defaultValue={["bold", "italic"]}
  >
    <ToggleGroup.Item value="bold" ariaLabel="Toggle bold">
      <Icons.Bold />
    </ToggleGroup.Item>
    <ToggleGroup.Item value="italic" ariaLabel="Toggle italic">
      <Icons.Italic />
    </ToggleGroup.Item>
    <ToggleGroup.Item value="underline" ariaLabel="Toggle underline">
      <Icons.Underline />
    </ToggleGroup.Item>
  </ToggleGroup>
