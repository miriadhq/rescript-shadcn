@react.component
let make = () =>
  <Menubar className="w-72">
    <Menubar.Menu>
      <Menubar.Trigger> {"File"->React.string} </Menubar.Trigger>
      <Menubar.Content>
        <Menubar.Item>
          <Icons.File />
          {"New File"->React.string}
          <Menubar.Shortcut> {"⌘N"->React.string} </Menubar.Shortcut>
        </Menubar.Item>
        <Menubar.Item>
          <Icons.Folder />
          {"Open Folder"->React.string}
        </Menubar.Item>
        <Menubar.Separator />
        <Menubar.Item>
          <Icons.Save />
          {"Save"->React.string}
          <Menubar.Shortcut> {"⌘S"->React.string} </Menubar.Shortcut>
        </Menubar.Item>
      </Menubar.Content>
    </Menubar.Menu>
    <Menubar.Menu>
      <Menubar.Trigger> {"More"->React.string} </Menubar.Trigger>
      <Menubar.Content>
        <Menubar.Group>
          <Menubar.Item>
            <Icons.Settings />
            {"Settings"->React.string}
          </Menubar.Item>
          <Menubar.Item>
            <Icons.HelpCircle />
            {"Help"->React.string}
          </Menubar.Item>
          <Menubar.Separator />
          <Menubar.Item variant=Menubar.Variant.Destructive>
            <Icons.Trash />
            {"Delete"->React.string}
          </Menubar.Item>
        </Menubar.Group>
      </Menubar.Content>
    </Menubar.Menu>
  </Menubar>
