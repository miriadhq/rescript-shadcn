@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex w-full max-w-md flex-col gap-3">
    <Attachment state=Uploading className="w-full">
      <Attachment.Media>
        <Icons.FileText />
      </Attachment.Media>
      <Attachment.Content>
        <Attachment.Title> {"quarterly-review.pdf"->React.string} </Attachment.Title>
        <Attachment.Description> {"Uploading..."->React.string} </Attachment.Description>
      </Attachment.Content>
      <Attachment.Actions>
        <Spinner className="size-4" />
      </Attachment.Actions>
    </Attachment>
    <Attachment state=Processing className="w-full">
      <Attachment.Media>
        <Icons.FileCode />
      </Attachment.Media>
      <Attachment.Content>
        <Attachment.Title> {"transcript.json"->React.string} </Attachment.Title>
        <Attachment.Description> {"Processing metadata"->React.string} </Attachment.Description>
      </Attachment.Content>
    </Attachment>
    <Attachment state=Error className="w-full">
      <Attachment.Media>
        <Icons.TriangleAlert />
      </Attachment.Media>
      <Attachment.Content>
        <Attachment.Title> {"large-export.zip"->React.string} </Attachment.Title>
        <Attachment.Description> {"Upload failed"->React.string} </Attachment.Description>
      </Attachment.Content>
      <Attachment.Actions>
        <Button variant=Outline size=Sm> {"Retry"->React.string} </Button>
      </Attachment.Actions>
    </Attachment>
  </div>
