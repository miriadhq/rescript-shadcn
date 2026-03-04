@react.component
let make = () =>
  <Field orientation=BaseUi.Types.Orientation.Horizontal>
    <Input type_="search" placeholder="Search..." />
    <Button> {"Search"->React.string} </Button>
  </Field>
