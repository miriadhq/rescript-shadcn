@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <AlertDialog>
    <AlertDialog.Trigger
      render={<Button variant=Destructive> {"Delete Chat"->React.string} </Button>}
    />
    <AlertDialog.Content size=Sm>
      <AlertDialog.Header>
        <AlertDialog.Media
          className="bg-destructive/10 text-destructive dark:bg-destructive/20 dark:text-destructive"
        >
          <Icons.Trash2 />
        </AlertDialog.Media>
        <AlertDialog.Title> {"Delete chat?"->React.string} </AlertDialog.Title>
        <AlertDialog.Description>
          {"This will permanently delete this chat conversation. View "->React.string}
          <a href="#"> {"Settings"->React.string} </a>
          {" delete any memories saved during this chat."->React.string}
        </AlertDialog.Description>
      </AlertDialog.Header>
      <AlertDialog.Footer>
        <AlertDialog.Cancel variant=Outline> {"Cancel"->React.string} </AlertDialog.Cancel>
        <AlertDialog.Action variant=AlertDialog.Variant.Destructive>
          {"Delete"->React.string}
        </AlertDialog.Action>
      </AlertDialog.Footer>
    </AlertDialog.Content>
  </AlertDialog>
