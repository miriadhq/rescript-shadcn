@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <ButtonGroup>
    <Input placeholder="Search..." />
    <Button variant=Outline ariaLabel="Search">
      <Icons.Search />
    </Button>
  </ButtonGroup>
