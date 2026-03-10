@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <ButtonGroup>
    <Button variant=Button.Variant.Secondary size=Button.Size.Sm> {"Copy"->React.string} </Button>
    <ButtonGroup.Separator />
    <Button variant=Button.Variant.Secondary size=Button.Size.Sm> {"Paste"->React.string} </Button>
  </ButtonGroup>
