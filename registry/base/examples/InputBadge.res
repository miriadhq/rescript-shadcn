@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Field>
    <Field.Label htmlFor="input-badge">
      {"Webhook URL "->React.string}
      <Badge variant=Badge.Variant.Secondary className="ml-auto"> {"Beta"->React.string} </Badge>
    </Field.Label>
    <Input id="input-badge" type_="url" placeholder="https://api.example.com/webhook" />
  </Field>
