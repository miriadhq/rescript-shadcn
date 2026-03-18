@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="w-full max-w-lg">
    <form>
      <Field.Set>
        <Field.Legend> {"Profile"->React.string} </Field.Legend>
        <Field.Description> {"Fill in your profile information."->React.string} </Field.Description>
        <Field.Group>
          <Field dataOrientation=Field.DataOrientation.Responsive>
            <Field.Content>
              <Field.Label htmlFor="name"> {"Name"->React.string} </Field.Label>
              <Field.Description>
                {"Provide your full name for identification"->React.string}
              </Field.Description>
            </Field.Content>
            <Input id="name" placeholder="Evil Rabbit" required={true} />
          </Field>
          <Field dataOrientation=Field.DataOrientation.Responsive>
            <Button type_="submit"> {"Submit"->React.string} </Button>
            <Button type_="button" variant=Button.Variant.Outline>
              {"Cancel"->React.string}
            </Button>
          </Field>
        </Field.Group>
      </Field.Set>
    </form>
  </div>
