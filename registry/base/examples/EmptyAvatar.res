@react.component
let make = () =>
  <Empty>
    <Empty.Header>
      <Empty.Media variant=Empty.Variant.Default>
        <Avatar className="size-12">
          <Avatar.Image src="https://github.com/shadcn.png" className="grayscale" />
          <Avatar.Fallback> {"LR"->React.string} </Avatar.Fallback>
        </Avatar>
      </Empty.Media>
      <Empty.Title> {"User Offline"->React.string} </Empty.Title>
      <Empty.Description>
        {"This user is currently offline. You can leave a message to notify them or try again later."->React.string}
      </Empty.Description>
    </Empty.Header>
    <Empty.Content>
      <Button size=Button.Size.Sm> {"Leave Message"->React.string} </Button>
    </Empty.Content>
  </Empty>
