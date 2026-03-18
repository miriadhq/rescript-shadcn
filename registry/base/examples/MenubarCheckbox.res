@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Menubar className="w-72">
    <Menubar.Menu>
      <Menubar.Trigger> {"View"->React.string} </Menubar.Trigger>
      <Menubar.Content className="w-64">
        <Menubar.CheckboxItem> {"Always Show Bookmarks Bar"->React.string} </Menubar.CheckboxItem>
        <Menubar.CheckboxItem checked=true>
          {"Always Show Full URLs"->React.string}
        </Menubar.CheckboxItem>
        <Menubar.Separator />
        <Menubar.Item inset=true>
          {"Reload"->React.string}
          <Menubar.Shortcut> {"⌘R"->React.string} </Menubar.Shortcut>
        </Menubar.Item>
        <Menubar.Item disabled=true inset=true>
          {"Force Reload"->React.string}
          <Menubar.Shortcut> {"⇧⌘R"->React.string} </Menubar.Shortcut>
        </Menubar.Item>
      </Menubar.Content>
    </Menubar.Menu>
    <Menubar.Menu>
      <Menubar.Trigger> {"Format"->React.string} </Menubar.Trigger>
      <Menubar.Content>
        <Menubar.CheckboxItem checked=true> {"Strikethrough"->React.string} </Menubar.CheckboxItem>
        <Menubar.CheckboxItem> {"Code"->React.string} </Menubar.CheckboxItem>
        <Menubar.CheckboxItem> {"Superscript"->React.string} </Menubar.CheckboxItem>
      </Menubar.Content>
    </Menubar.Menu>
  </Menubar>
