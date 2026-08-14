@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Dialog.Trigger>
    <Button variant=Outline> {"No Close Button"->React.string} </Button>
    <Dialog showCloseButton=false>
      <Dialog.Header>
        <Dialog.Title> {"No Close Button"->React.string} </Dialog.Title>
        <Dialog.Description>
          {"This dialog doesn't have a close button in the top-right corner."->React.string}
        </Dialog.Description>
      </Dialog.Header>
    </Dialog>
  </Dialog.Trigger>
