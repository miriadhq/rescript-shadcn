@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Empty className="border border-dashed">
    <Empty.Header>
      <Empty.Media variant=Empty.Variant.Icon>
        <Icons.Cloud />
      </Empty.Media>
      <Empty.Title> {"Cloud Storage Empty"->React.string} </Empty.Title>
      <Empty.Description>
        {"Upload files to your cloud storage to access them anywhere."->React.string}
      </Empty.Description>
    </Empty.Header>
    <Empty.Content>
      <Button variant=Button.Variant.Outline size=Button.Size.Sm>
        {"Upload Files"->React.string}
      </Button>
    </Empty.Content>
  </Empty>
