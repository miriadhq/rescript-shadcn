@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Dialog>
    <Dialog.Trigger render={<Button variant=Button.Variant.Outline dataSlot="dialog-trigger" />}>
      {"No Close Button"->React.string}
    </Dialog.Trigger>
    <Dialog.Content showCloseButton=false>
      <Dialog.Header>
        <Dialog.Title> {"No Close Button"->React.string} </Dialog.Title>
        <Dialog.Description>
          {"This dialog doesn't have a close button in the top-right corner."->React.string}
        </Dialog.Description>
      </Dialog.Header>
    </Dialog.Content>
  </Dialog>
