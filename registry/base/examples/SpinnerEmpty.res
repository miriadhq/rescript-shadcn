@react.component
let make = () =>
  <Empty className="w-full">
    <Empty.Header>
      <Empty.Media variant=Empty.Variant.Icon>
        <Spinner />
      </Empty.Media>
      <Empty.Title> {"Processing your request"->React.string} </Empty.Title>
      <Empty.Description>
        {"Please wait while we process your request. Do not refresh the page."->React.string}
      </Empty.Description>
    </Empty.Header>
    <Empty.Content>
      <Button variant=Button.Variant.Outline size=Button.Size.Sm> {"Cancel"->React.string} </Button>
    </Empty.Content>
  </Empty>
