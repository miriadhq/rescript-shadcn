@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Field dataInvalid=true>
    <Field.Label htmlFor="textarea-invalid"> {"Message"->React.string} </Field.Label>
    <Textarea id="textarea-invalid" placeholder="Type your message here." ariaInvalid=#"true" />
    <Field.Description> {"Please enter a valid message."->React.string} </Field.Description>
  </Field>
