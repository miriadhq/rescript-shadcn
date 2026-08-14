@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="mx-auto flex w-full max-w-sm flex-col gap-3 py-12">
    <Attachment size=Default className="w-full">
      <Attachment.Media> <Icons.FileText /> </Attachment.Media>
      <Attachment.Content>
        <Attachment.Title> {"Default attachment"->React.string} </Attachment.Title>
        <Attachment.Description> {"PDF · 2.4 MB"->React.string} </Attachment.Description>
      </Attachment.Content>
    </Attachment>
    <Attachment size=Sm className="w-full">
      <Attachment.Media> <Icons.FileText /> </Attachment.Media>
      <Attachment.Content>
        <Attachment.Title> {"Small attachment"->React.string} </Attachment.Title>
        <Attachment.Description> {"PDF · 2.4 MB"->React.string} </Attachment.Description>
      </Attachment.Content>
    </Attachment>
    <Attachment size=Xs className="w-full">
      <Attachment.Media> <Icons.FileText /> </Attachment.Media>
      <Attachment.Content>
        <Attachment.Title> {"Extra small attachment"->React.string} </Attachment.Title>
      </Attachment.Content>
    </Attachment>
  </div>
