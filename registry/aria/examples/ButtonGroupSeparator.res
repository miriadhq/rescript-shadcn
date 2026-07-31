@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <ButtonGroup>
    <Button variant=Secondary size=Sm> {"Copy"->React.string} </Button>
    <ButtonGroup.Separator />
    <Button variant=Secondary size=Sm> {"Paste"->React.string} </Button>
  </ButtonGroup>
