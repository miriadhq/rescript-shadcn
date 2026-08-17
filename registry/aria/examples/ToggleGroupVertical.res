@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <ToggleGroup
    selectionMode=ReactAria.Common.SelectionMode.Multiple
    orientation=ToggleGroup.Orientation.Vertical
    spacing=1.
    defaultSelectedKeys={["bold", "italic"]}
  >
    <ToggleGroup.Item id="bold" ariaLabel="Toggle bold">
      <Icons.Bold />
    </ToggleGroup.Item>
    <ToggleGroup.Item id="italic" ariaLabel="Toggle italic">
      <Icons.Italic />
    </ToggleGroup.Item>
    <ToggleGroup.Item id="underline" ariaLabel="Toggle underline">
      <Icons.Underline />
    </ToggleGroup.Item>
  </ToggleGroup>
