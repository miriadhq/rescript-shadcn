@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex w-full max-w-md flex-col gap-3">
    <Attachment className="w-full">
      <Attachment.Media>
        <Icons.FileText />
      </Attachment.Media>
      <Attachment.Content>
        <Attachment.Title> {"sales-dashboard.pdf"->React.string} </Attachment.Title>
        <Attachment.Description> {"PDF - 2.4 MB"->React.string} </Attachment.Description>
      </Attachment.Content>
      <Attachment.Actions>
        <Attachment.Action ariaLabel="Remove sales-dashboard.pdf">
          <Icons.X />
        </Attachment.Action>
      </Attachment.Actions>
    </Attachment>
    <Attachment className="w-full">
      <Attachment.Media>
        <Icons.FileCode />
      </Attachment.Media>
      <Attachment.Content>
        <Attachment.Title> {"message-renderer.res"->React.string} </Attachment.Title>
        <Attachment.Description> {"ReScript - 12 KB"->React.string} </Attachment.Description>
      </Attachment.Content>
      <Attachment.Actions>
        <Attachment.Action ariaLabel="Download message-renderer.res">
          <Icons.Download />
        </Attachment.Action>
      </Attachment.Actions>
    </Attachment>
  </div>
