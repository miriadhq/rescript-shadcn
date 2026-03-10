@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <ContextMenu>
    <ContextMenu.Trigger
      className="flex aspect-video w-full max-w-xs items-center justify-center rounded-xl border border-dashed text-sm"
    >
      <span className="hidden pointer-fine:inline-block"> {"Right click here"->React.string} </span>
      <span className="hidden pointer-coarse:inline-block">
        {"Long press here"->React.string}
      </span>
    </ContextMenu.Trigger>
    <ContextMenu.Content>
      <ContextMenu.Group>
        <ContextMenu.Item>
          {"Copy"->React.string}
          <ContextMenu.Shortcut> {"\u2318C"->React.string} </ContextMenu.Shortcut>
        </ContextMenu.Item>
        <ContextMenu.Item>
          {"Cut"->React.string}
          <ContextMenu.Shortcut> {"\u2318X"->React.string} </ContextMenu.Shortcut>
        </ContextMenu.Item>
      </ContextMenu.Group>
      <ContextMenu.Sub>
        <ContextMenu.SubTrigger> {"More Tools"->React.string} </ContextMenu.SubTrigger>
        <ContextMenu.SubContent>
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
    </ContextMenu.Content>
  </ContextMenu>
