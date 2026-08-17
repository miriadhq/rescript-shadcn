@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Card className="mx-auto w-fit p-0">
    <Card.Content className="p-0">
      <Calendar selectionMode=ReactAria.Calendar.SelectionMode.Multiple />
    </Card.Content>
  </Card>
