@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Field orientation=Horizontal>
    <Input type_="search" placeholder="Search..." />
    <Button> {"Search"->React.string} </Button>
  </Field>
