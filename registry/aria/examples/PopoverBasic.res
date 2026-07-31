@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  <Popover>
    <Popover.Trigger render={<Button variant=Outline className="w-fit" />}>
      {"Open Popover"->React.string}
    </Popover.Trigger>
    <Popover.Content align=Start>
      <Popover.Header>
        <Popover.Title> {"Dimensions"->React.string} </Popover.Title>
        <Popover.Description>
          {"Set the dimensions for the layer."->React.string}
        </Popover.Description>
      </Popover.Header>
    </Popover.Content>
  </Popover>
}
