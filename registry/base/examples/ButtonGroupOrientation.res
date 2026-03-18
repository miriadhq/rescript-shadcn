@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <ButtonGroup
    orientation=ButtonGroup.DataOrientation.Vertical ariaLabel="Media controls" className="h-fit"
  >
    <Button variant=Button.Variant.Outline size=Button.Size.Icon>
      <Icons.Plus />
    </Button>
    <Button variant=Button.Variant.Outline size=Button.Size.Icon>
      <Icons.Minus />
    </Button>
  </ButtonGroup>
