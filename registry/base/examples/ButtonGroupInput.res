@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <ButtonGroup>
    <Input placeholder="Search..." />
    <Button variant=Button.Variant.Outline ariaLabel="Search">
      <Icons.Search />
    </Button>
  </ButtonGroup>
