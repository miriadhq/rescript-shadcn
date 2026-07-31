@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <ButtonGroup orientation=Vertical ariaLabel="Media controls" className="h-fit">
    <Button variant=Outline size=Icon>
      <Icons.Plus />
    </Button>
    <Button variant=Outline size=Icon>
      <Icons.Minus />
    </Button>
  </ButtonGroup>
