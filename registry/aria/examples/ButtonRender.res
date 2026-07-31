@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Button variant=Secondary size=Sm nativeButton=false render={<a href="#" />}>
    {"Login"->React.string}
  </Button>
