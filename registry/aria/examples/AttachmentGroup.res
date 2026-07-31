@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Attachment.Group className="w-full max-w-md">
    <Attachment orientation=Vertical>
      <Attachment.Media>
        <Icons.FileText />
      </Attachment.Media>
      <Attachment.Content>
        <Attachment.Title> {"brief.pdf"->React.string} </Attachment.Title>
        <Attachment.Description> {"PDF - 640 KB"->React.string} </Attachment.Description>
      </Attachment.Content>
    </Attachment>
    <Attachment orientation=Vertical>
      <Attachment.Media>
        <Icons.FileCode />
      </Attachment.Media>
      <Attachment.Content>
        <Attachment.Title> {"schema.sql"->React.string} </Attachment.Title>
        <Attachment.Description> {"SQL - 18 KB"->React.string} </Attachment.Description>
      </Attachment.Content>
    </Attachment>
    <Attachment orientation=Vertical>
      <Attachment.Media>
        <Icons.Image />
      </Attachment.Media>
      <Attachment.Content>
        <Attachment.Title> {"wireframe.png"->React.string} </Attachment.Title>
        <Attachment.Description> {"PNG - 420 KB"->React.string} </Attachment.Description>
      </Attachment.Content>
    </Attachment>
  </Attachment.Group>
