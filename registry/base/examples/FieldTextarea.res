@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Field.Set className="w-full max-w-xs">
    <Field.Group>
      <Field>
        <Field.Label htmlFor="feedback"> {"Feedback"->React.string} </Field.Label>
        <Textarea id="feedback" placeholder="Your feedback helps us improve..." rows={4} />
        <Field.Description>
          {"Share your thoughts about our service."->React.string}
        </Field.Description>
      </Field>
    </Field.Group>
  </Field.Set>
