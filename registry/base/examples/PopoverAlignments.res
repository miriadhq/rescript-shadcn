@react.component
let make = () => {
  <div className="flex gap-6">
    <Popover>
      <Popover.Trigger render={<Button variant=Outline size=Sm />}>
        {"Start"->React.string}
      </Popover.Trigger>
      <Popover.Content align=BaseUi.Types.Align.Start className="w-40">
        {"Aligned to start"->React.string}
      </Popover.Content>
    </Popover>
    <Popover>
      <Popover.Trigger render={<Button variant=Outline size=Sm />}>
        {"Center"->React.string}
      </Popover.Trigger>
      <Popover.Content align=BaseUi.Types.Align.Center className="w-40">
        {"Aligned to center"->React.string}
      </Popover.Content>
    </Popover>
    <Popover>
      <Popover.Trigger render={<Button variant=Outline size=Sm />}>
        {"End"->React.string}
      </Popover.Trigger>
      <Popover.Content align=BaseUi.Types.Align.End className="w-40">
        {"Aligned to end"->React.string}
      </Popover.Content>
    </Popover>
  </div>
}
