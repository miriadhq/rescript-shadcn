@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Dialog.Trigger>
    <Button variant=Outline> {"Share"->React.string} </Button>
    <Dialog className="sm:max-w-md">
      <Dialog.Header>
        <Dialog.Title> {"Share link"->React.string} </Dialog.Title>
        <Dialog.Description>
          {"Anyone who has this link will be able to view this."->React.string}
        </Dialog.Description>
      </Dialog.Header>
      <div className="flex items-center gap-2">
        <div className="grid flex-1 gap-2">
          <Label htmlFor="link" className="sr-only"> {"Link"->React.string} </Label>
          <Input id="link" defaultValue="https://ui.shadcn.com/docs/installation" readOnly=true />
        </div>
      </div>
      <Dialog.Footer className="sm:justify-start">
        <Dialog.Close type_="button"> {"Close"->React.string} </Dialog.Close>
      </Dialog.Footer>
    </Dialog>
  </Dialog.Trigger>
