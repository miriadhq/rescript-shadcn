@react.component
let make = () =>
  <Menubar className="w-72">
    <Menubar.Menu>
      <Menubar.Trigger> {"File"->React.string} </Menubar.Trigger>
      <Menubar.Content>
        <Menubar.Sub>
          <Menubar.SubTrigger> {"Share"->React.string} </Menubar.SubTrigger>
          <Menubar.SubContent>
            <Menubar.Item> {"Email link"->React.string} </Menubar.Item>
            <Menubar.Item> {"Messages"->React.string} </Menubar.Item>
            <Menubar.Item> {"Notes"->React.string} </Menubar.Item>
          </Menubar.SubContent>
        </Menubar.Sub>
        <Menubar.Separator />
        <Menubar.Item>
          {"Print..."->React.string}
          <Menubar.Shortcut> {"⌘P"->React.string} </Menubar.Shortcut>
        </Menubar.Item>
      </Menubar.Content>
    </Menubar.Menu>
    <Menubar.Menu>
      <Menubar.Trigger> {"Edit"->React.string} </Menubar.Trigger>
      <Menubar.Content>
        <Menubar.Item>
          {"Undo"->React.string}
          <Menubar.Shortcut> {"⌘Z"->React.string} </Menubar.Shortcut>
        </Menubar.Item>
        <Menubar.Item>
          {"Redo"->React.string}
          <Menubar.Shortcut> {"⇧⌘Z"->React.string} </Menubar.Shortcut>
        </Menubar.Item>
        <Menubar.Separator />
        <Menubar.Sub>
          <Menubar.SubTrigger> {"Find"->React.string} </Menubar.SubTrigger>
          <Menubar.SubContent>
            <Menubar.Item> {"Find..."->React.string} </Menubar.Item>
            <Menubar.Item> {"Find Next"->React.string} </Menubar.Item>
            <Menubar.Item> {"Find Previous"->React.string} </Menubar.Item>
          </Menubar.SubContent>
        </Menubar.Sub>
        <Menubar.Separator />
        <Menubar.Item> {"Cut"->React.string} </Menubar.Item>
        <Menubar.Item> {"Copy"->React.string} </Menubar.Item>
        <Menubar.Item> {"Paste"->React.string} </Menubar.Item>
      </Menubar.Content>
    </Menubar.Menu>
  </Menubar>
