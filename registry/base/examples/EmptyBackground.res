@react.component
let make = () =>
  <Empty className="bg-muted/30 h-full">
    <Empty.Header>
      <Empty.Media variant=Empty.Variant.Icon>
        <Icons.Bell />
      </Empty.Media>
      <Empty.Title> {"No Notifications"->React.string} </Empty.Title>
      <Empty.Description className="max-w-xs text-pretty">
        {"You're all caught up. New notifications will appear here."->React.string}
      </Empty.Description>
    </Empty.Header>
    <Empty.Content>
      <Button variant=Button.Variant.Outline>
        <Icons.RefreshCcw dataIcon="inline-start" />
        {"Refresh"->React.string}
      </Button>
    </Empty.Content>
  </Empty>
