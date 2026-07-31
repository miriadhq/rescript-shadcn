@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Alert className="max-w-md">
    <Alert.Title> {"Dark mode is now available"->React.string} </Alert.Title>
    <Alert.Description>
      {"Enable it under your profile settings to get started."->React.string}
    </Alert.Description>
    <Alert.Action>
      <Button size=Xs variant=Default> {"Enable"->React.string} </Button>
    </Alert.Action>
  </Alert>
