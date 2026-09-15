module FileWarningIcon = {
  @module("lucide-react") external make: React.component<Icons.props> = "FileWarningIcon"
}

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="mx-auto flex w-full max-w-sm flex-col gap-2 py-12">
    <Attachment state=Idle className="w-full">
      <Attachment.Media>
        <Icons.Clock />
      </Attachment.Media>
      <Attachment.Content>
        <Attachment.Title> {"selected-file.pdf"->React.string} </Attachment.Title>
        <Attachment.Description> {"Ready to upload"->React.string} </Attachment.Description>
      </Attachment.Content>
      <Attachment.Actions>
        <Attachment.Action ariaLabel="Remove selected-file.pdf">
          <Icons.X />
        </Attachment.Action>
      </Attachment.Actions>
    </Attachment>
    <Attachment state=Uploading className="w-full">
      <Attachment.Media>
        <Spinner />
      </Attachment.Media>
      <Attachment.Content>
        <Attachment.Title> {"design-system.zip"->React.string} </Attachment.Title>
        <Attachment.Description> {"Uploading · 64%"->React.string} </Attachment.Description>
      </Attachment.Content>
      <Attachment.Actions>
        <Attachment.Action ariaLabel="Cancel upload">
          <Icons.X />
        </Attachment.Action>
      </Attachment.Actions>
    </Attachment>
    <Attachment state=Processing className="w-full">
      <Attachment.Media>
        <Icons.FileText />
      </Attachment.Media>
      <Attachment.Content>
        <Attachment.Title> {"market-research.pdf"->React.string} </Attachment.Title>
        <Attachment.Description> {"Processing document"->React.string} </Attachment.Description>
      </Attachment.Content>
      <Attachment.Actions>
        <Attachment.Action ariaLabel="Remove market-research.pdf">
          <Icons.X />
        </Attachment.Action>
      </Attachment.Actions>
    </Attachment>
    <Attachment state=Error className="w-full">
      <Attachment.Media>
        <FileWarningIcon />
      </Attachment.Media>
      <Attachment.Content>
        <Attachment.Title> {"financial-model.xlsx"->React.string} </Attachment.Title>
        <Attachment.Description>
          {"Upload failed. Try again."->React.string}
        </Attachment.Description>
      </Attachment.Content>
      <Attachment.Actions>
        <Attachment.Action ariaLabel="Retry upload">
          <Icons.RefreshCw />
        </Attachment.Action>
        <Attachment.Action ariaLabel="Remove financial-model.xlsx">
          <Icons.X />
        </Attachment.Action>
      </Attachment.Actions>
    </Attachment>
    <Attachment state=Done className="w-full">
      <Attachment.Media>
        <Icons.Check />
      </Attachment.Media>
      <Attachment.Content>
        <Attachment.Title> {"uploaded-report.pdf"->React.string} </Attachment.Title>
        <Attachment.Description> {"Uploaded · 1.8 MB"->React.string} </Attachment.Description>
      </Attachment.Content>
      <Attachment.Actions>
        <Attachment.Action ariaLabel="Remove uploaded-report.pdf">
          <Icons.X />
        </Attachment.Action>
      </Attachment.Actions>
    </Attachment>
  </div>
