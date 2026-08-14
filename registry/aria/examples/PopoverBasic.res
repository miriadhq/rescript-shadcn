@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  <Popover.Trigger>
    <Button variant=Outline className="w-fit"> {"Open Popover"->React.string} </Button>
    <Popover placement=ReactAria.Common.BottomStart>
      <Popover.Header>
        <Popover.Title> {"Dimensions"->React.string} </Popover.Title>
        <Popover.Description>
          {"Set the dimensions for the layer."->React.string}
        </Popover.Description>
      </Popover.Header>
    </Popover>
  </Popover.Trigger>
}
