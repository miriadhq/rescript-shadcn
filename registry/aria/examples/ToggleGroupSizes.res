@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex flex-col gap-4">
    <ToggleGroup size=ToggleGroup.Size.Sm defaultSelectedKeys={["top"]} variant=Outline>
      <ToggleGroup.Item id="top" ariaLabel="Toggle top"> {"Top"->React.string} </ToggleGroup.Item>
      <ToggleGroup.Item id="bottom" ariaLabel="Toggle bottom">
        {"Bottom"->React.string}
      </ToggleGroup.Item>
      <ToggleGroup.Item id="left" ariaLabel="Toggle left">
        {"Left"->React.string}
      </ToggleGroup.Item>
      <ToggleGroup.Item id="right" ariaLabel="Toggle right">
        {"Right"->React.string}
      </ToggleGroup.Item>
    </ToggleGroup>
    <ToggleGroup defaultSelectedKeys={["top"]} variant=Outline>
      <ToggleGroup.Item id="top" ariaLabel="Toggle top"> {"Top"->React.string} </ToggleGroup.Item>
      <ToggleGroup.Item id="bottom" ariaLabel="Toggle bottom">
        {"Bottom"->React.string}
      </ToggleGroup.Item>
      <ToggleGroup.Item id="left" ariaLabel="Toggle left">
        {"Left"->React.string}
      </ToggleGroup.Item>
      <ToggleGroup.Item id="right" ariaLabel="Toggle right">
        {"Right"->React.string}
      </ToggleGroup.Item>
    </ToggleGroup>
  </div>
