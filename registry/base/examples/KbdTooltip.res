@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex flex-wrap gap-4">
    <ButtonGroup>
      <Tooltip>
        <Tooltip.Trigger render={<Button variant=Button.Variant.Outline />}>
          {"Save"->React.string}
        </Tooltip.Trigger>
        <Tooltip.Content className="pr-1.5">
          <div className="flex items-center gap-2">
            {"Save Changes "->React.string}
            <Kbd> {"S"->React.string} </Kbd>
          </div>
        </Tooltip.Content>
      </Tooltip>
      <Tooltip>
        <Tooltip.Trigger render={<Button variant=Button.Variant.Outline />}>
          {"Print"->React.string}
        </Tooltip.Trigger>
        <Tooltip.Content className="pr-1.5">
          <div className="flex items-center gap-2">
            {"Print Document "->React.string}
            <Kbd.Group>
              <Kbd> {"Ctrl"->React.string} </Kbd>
              <Kbd> {"P"->React.string} </Kbd>
            </Kbd.Group>
          </div>
        </Tooltip.Content>
      </Tooltip>
    </ButtonGroup>
  </div>
