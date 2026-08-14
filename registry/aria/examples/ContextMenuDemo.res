@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <ContextMenu.Trigger
    className="flex aspect-video w-full max-w-xs items-center justify-center rounded-xl border border-dashed text-sm"
  >
    <span className="hidden pointer-fine:inline-block"> {"Right click here"->React.string} </span>
    <span className="hidden pointer-coarse:inline-block"> {"Long press here"->React.string} </span>

    <ContextMenu className="w-48">
      <ContextMenu.Group>
        <ContextMenu.Item>
          {"Back"->React.string}
          <ContextMenu.Shortcut> {"⌘["->React.string} </ContextMenu.Shortcut>
        </ContextMenu.Item>
        <ContextMenu.Item isDisabled=true>
          {"Forward"->React.string}
          <ContextMenu.Shortcut> {"⌘]"->React.string} </ContextMenu.Shortcut>
        </ContextMenu.Item>
        <ContextMenu.Item>
          {"Reload"->React.string}
          <ContextMenu.Shortcut> {"⌘R"->React.string} </ContextMenu.Shortcut>
        </ContextMenu.Item>
        <ContextMenu.Sub>
          <ContextMenu.SubTrigger> {"More Tools"->React.string} </ContextMenu.SubTrigger>
          <ContextMenu.SubContent className="w-44">
            <ContextMenu.Group>
              <ContextMenu.Item> {"Save Page..."->React.string} </ContextMenu.Item>
              <ContextMenu.Item> {"Create Shortcut..."->React.string} </ContextMenu.Item>
              <ContextMenu.Item> {"Name Window..."->React.string} </ContextMenu.Item>
            </ContextMenu.Group>
            <ContextMenu.Separator />
            <ContextMenu.Group>
              <ContextMenu.Item> {"Developer Tools"->React.string} </ContextMenu.Item>
            </ContextMenu.Group>
            <ContextMenu.Separator />
            <ContextMenu.Group>
              <ContextMenu.Item variant=ContextMenu.Variant.Destructive>
                {"Delete"->React.string}
              </ContextMenu.Item>
            </ContextMenu.Group>
          </ContextMenu.SubContent>
        </ContextMenu.Sub>
      </ContextMenu.Group>
      <ContextMenu.Separator />
      <ContextMenu.Group selectionMode=Multiple defaultSelectedKeys={["bookmarks"]}>
        <ContextMenu.Item id="bookmarks"> {"Show Bookmarks"->React.string} </ContextMenu.Item>
        <ContextMenu.Item id="full-urls"> {"Show Full URLs"->React.string} </ContextMenu.Item>
      </ContextMenu.Group>
      <ContextMenu.Separator />
      <ContextMenu.Group selectionMode=Single defaultSelectedKeys={["pedro"]}>
        <ContextMenu.Label> {"People"->React.string} </ContextMenu.Label>
        <ContextMenu.Item id="pedro"> {"Pedro Duarte"->React.string} </ContextMenu.Item>
        <ContextMenu.Item id="colm"> {"Colm Tuite"->React.string} </ContextMenu.Item>
      </ContextMenu.Group>
    </ContextMenu>
  </ContextMenu.Trigger>
