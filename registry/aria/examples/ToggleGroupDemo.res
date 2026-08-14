@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <ToggleGroup variant=Outline selectionMode=ReactAria.Common.Multiple>
    <ToggleGroup.Item id="bold" ariaLabel="Toggle bold">
      <Icons.Bold />
    </ToggleGroup.Item>
    <ToggleGroup.Item id="italic" ariaLabel="Toggle italic">
      <Icons.Italic />
    </ToggleGroup.Item>
    <ToggleGroup.Item id="strikethrough" ariaLabel="Toggle strikethrough">
      <Icons.Underline />
    </ToggleGroup.Item>
  </ToggleGroup>
