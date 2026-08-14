@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Dialog.Trigger>
    <Button variant=Outline> {"Open Dialog"->React.string} </Button>
    <Dialog className="sm:max-w-sm">
      <form>
        <Dialog.Header>
          <Dialog.Title> {"Edit profile"->React.string} </Dialog.Title>
          <Dialog.Description>
            {"Make changes to your profile here. Click save when you're done."->React.string}
          </Dialog.Description>
        </Dialog.Header>
        <Field.Group>
          <Field>
            <Label htmlFor="name-1"> {"Name"->React.string} </Label>
            <Input id="name-1" name="name" defaultValue="Pedro Duarte" />
          </Field>
          <Field>
            <Label htmlFor="username-1"> {"Username"->React.string} </Label>
            <Input id="username-1" name="username" defaultValue="@peduarte" />
          </Field>
        </Field.Group>
        <Dialog.Footer>
          <Dialog.Close variant=Outline>
            {"Cancel"->React.string}
          </Dialog.Close>
          <Button type_="submit"> {"Save changes"->React.string} </Button>
        </Dialog.Footer>
      </form>
    </Dialog>
  </Dialog.Trigger>
