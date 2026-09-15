module FileSearchIcon = {
  @module("lucide-react") external make: React.component<Icons.props> = "FileSearchIcon"
}

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="mx-auto w-full max-w-sm py-12">
    <Dialog.Trigger>
      <Attachment className="w-full">
        <Attachment.Media>
          <FileSearchIcon />
        </Attachment.Media>
        <Attachment.Content>
          <Attachment.Title> {"research-summary.pdf"->React.string} </Attachment.Title>
          <Attachment.Description> {"Open preview dialog"->React.string} </Attachment.Description>
        </Attachment.Content>
        <Attachment.Actions>
          <Attachment.Action ariaLabel="Copy link">
            <Icons.Copy />
          </Attachment.Action>
          <Attachment.Action ariaLabel="Remove research-summary.pdf">
            <Icons.X />
          </Attachment.Action>
        </Attachment.Actions>
        <Dialog.Trigger>
          <Attachment.Trigger ariaLabel="Preview research-summary.pdf" />
        </Dialog.Trigger>
      </Attachment>
      <Dialog className="sm:max-w-md">
        <Dialog.Header>
          <Dialog.Title> {"research-summary.pdf"->React.string} </Dialog.Title>
          <Dialog.Description>
            {"The attachment trigger fills the card and opens the dialog, while the actions stay independently clickable above it."->React.string}
          </Dialog.Description>
        </Dialog.Header>
      </Dialog>
    </Dialog.Trigger>
  </div>
