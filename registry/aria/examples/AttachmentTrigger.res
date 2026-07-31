@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Attachment className="w-full max-w-md">
    <Attachment.Media>
      <Icons.FileText />
    </Attachment.Media>
    <Attachment.Content>
      <Attachment.Title> {"research-summary.pdf"->React.string} </Attachment.Title>
      <Attachment.Description> {"Click the card to preview"->React.string} </Attachment.Description>
    </Attachment.Content>
    <Attachment.Actions>
      <Attachment.Action ariaLabel="Download research-summary.pdf">
        <Icons.Download />
      </Attachment.Action>
    </Attachment.Actions>
    <Attachment.Trigger ariaLabel="Preview research-summary.pdf" />
  </Attachment>
