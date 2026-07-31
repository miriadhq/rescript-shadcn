@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex flex-col gap-4">
    <ToggleGroup size=ToggleGroup.Size.Sm defaultValue={["top"]} variant=Outline>
      <ToggleGroup.Item value="top" ariaLabel="Toggle top">
        {"Top"->React.string}
      </ToggleGroup.Item>
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
    <ToggleGroup defaultValue={["top"]} variant=Outline>
      <ToggleGroup.Item value="top" ariaLabel="Toggle top">
        {"Top"->React.string}
      </ToggleGroup.Item>
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
  </div>
