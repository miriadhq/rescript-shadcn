@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Alert variant=Alert.Variant.Destructive className="max-w-md">
    <Icons.AlertCircle />
    <Alert.Title> {"Payment failed"->React.string} </Alert.Title>
    <Alert.Description>
      {"Your payment could not be processed. Please check your payment method and try again."->React.string}
    </Alert.Description>
  </Alert>
