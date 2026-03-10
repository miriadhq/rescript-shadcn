@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Button nativeButton={false} render={<a href="#" />}> {"Login"->React.string} </Button>
