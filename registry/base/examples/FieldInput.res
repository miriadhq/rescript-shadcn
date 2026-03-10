@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Field.Set className="w-full max-w-xs">
    <Field.Group>
      <Field>
        <Field.Label htmlFor="username"> {"Username"->React.string} </Field.Label>
        <Input id="username" type_="text" placeholder="Max Leiter" />
        <Field.Description>
          {"Choose a unique username for your account."->React.string}
        </Field.Description>
      </Field>
      <Field>
        <Field.Label htmlFor="password"> {"Password"->React.string} </Field.Label>
        <Field.Description>
          {"Must be at least 8 characters long."->React.string}
        </Field.Description>
        <Input id="password" type_="password" placeholder="••••••••" />
      </Field>
    </Field.Group>
  </Field.Set>
