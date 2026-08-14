@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <AlertDialog.Trigger>
    <Button variant=Outline> {"Show Dialog"->React.string} </Button>
    <AlertDialog size=AlertDialog.Size.Sm>
      <AlertDialog.Header>
        <AlertDialog.Media>
          <Icons.Bluetooth />
        </AlertDialog.Media>
        <AlertDialog.Title> {"Allow accessory to connect?"->React.string} </AlertDialog.Title>
        <AlertDialog.Description>
          {"Do you want to allow the USB accessory to connect to this device?"->React.string}
        </AlertDialog.Description>
      </AlertDialog.Header>
      <AlertDialog.Footer>
        <AlertDialog.Cancel> {"Don't allow"->React.string} </AlertDialog.Cancel>
        <AlertDialog.Action> {"Allow"->React.string} </AlertDialog.Action>
      </AlertDialog.Footer>
    </AlertDialog>
  </AlertDialog.Trigger>
