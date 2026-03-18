@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Card className="mx-auto w-fit p-0">
    <Card.Content className="p-0">
      <Calendar mode=Multiple />
    </Card.Content>
  </Card>
