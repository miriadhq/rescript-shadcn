@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  <div className="flex gap-6">
    <Popover>
      <Popover.Trigger render={<Button variant=Outline size=Sm />}>
        {"Start"->React.string}
      </Popover.Trigger>
      <Popover.Content align=Start className="w-40">
        {"Aligned to start"->React.string}
      </Popover.Content>
    </Popover>
    <Popover>
      <Popover.Trigger render={<Button variant=Outline size=Sm />}>
        {"Center"->React.string}
      </Popover.Trigger>
      <Popover.Content align=Center className="w-40">
        {"Aligned to center"->React.string}
      </Popover.Content>
    </Popover>
    <Popover>
      <Popover.Trigger render={<Button variant=Outline size=Sm />}>
        {"End"->React.string}
      </Popover.Trigger>
      <Popover.Content align=End className="w-40">
        {"Aligned to end"->React.string}
      </Popover.Content>
    </Popover>
  </div>
}
