@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex flex-wrap gap-4">
    <ButtonGroup>
      <Tooltip.Trigger>
        <Button variant=Outline> {"Save"->React.string} </Button>
        <Tooltip className="pr-1.5">
          <div className="flex items-center gap-2">
            {"Save Changes "->React.string}
            <Kbd> {"S"->React.string} </Kbd>
          </div>
        </Tooltip>
      </Tooltip.Trigger>
      <Tooltip.Trigger>
        <Button variant=Outline> {"Print"->React.string} </Button>
        <Tooltip className="pr-1.5">
          <div className="flex items-center gap-2">
            {"Print Document "->React.string}
            <Kbd.Group>
              <Kbd> {"Ctrl"->React.string} </Kbd>
              <Kbd> {"P"->React.string} </Kbd>
            </Kbd.Group>
          </div>
        </Tooltip>
      </Tooltip.Trigger>
    </ButtonGroup>
  </div>
