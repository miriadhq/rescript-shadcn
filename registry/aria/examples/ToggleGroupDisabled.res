@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <ToggleGroup disabled={true}>
    <ToggleGroup.Item value="bold" ariaLabel="Toggle bold">
      <Icons.Bold />
    </ToggleGroup.Item>
    <ToggleGroup.Item value="italic" ariaLabel="Toggle italic">
      <Icons.Italic />
    </ToggleGroup.Item>
    <ToggleGroup.Item value="strikethrough" ariaLabel="Toggle strikethrough">
      <Icons.Underline />
    </ToggleGroup.Item>
  </ToggleGroup>
