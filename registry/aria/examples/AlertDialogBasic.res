@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <AlertDialog.Trigger>
    <Button variant=Outline> {"Show Dialog"->React.string} </Button>
    <AlertDialog>
      <AlertDialog.Header>
        <AlertDialog.Title> {"Are you absolutely sure?"->React.string} </AlertDialog.Title>
        <AlertDialog.Description>
          {"This action cannot be undone. This will permanently delete your account and remove your data from our servers."->React.string}
        </AlertDialog.Description>
      </AlertDialog.Header>
      <AlertDialog.Footer>
        <AlertDialog.Cancel> {"Cancel"->React.string} </AlertDialog.Cancel>
        <AlertDialog.Action> {"Continue"->React.string} </AlertDialog.Action>
      </AlertDialog.Footer>
    </AlertDialog>
  </AlertDialog.Trigger>
