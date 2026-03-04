@react.component
let make = () =>
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
        <ContextMenu.Label> {"File"->React.string} </ContextMenu.Label>
        <ContextMenu.Item>
          {"New File"->React.string}
          <ContextMenu.Shortcut> {"\u2318N"->React.string} </ContextMenu.Shortcut>
        </ContextMenu.Item>
        <ContextMenu.Item>
          {"Open File"->React.string}
          <ContextMenu.Shortcut> {"\u2318O"->React.string} </ContextMenu.Shortcut>
        </ContextMenu.Item>
        <ContextMenu.Item>
          {"Save"->React.string}
          <ContextMenu.Shortcut> {"\u2318S"->React.string} </ContextMenu.Shortcut>
        </ContextMenu.Item>
      </ContextMenu.Group>
      <ContextMenu.Separator />
      <ContextMenu.Group>
        <ContextMenu.Label> {"Edit"->React.string} </ContextMenu.Label>
        <ContextMenu.Item>
          {"Undo"->React.string}
          <ContextMenu.Shortcut> {"\u2318Z"->React.string} </ContextMenu.Shortcut>
        </ContextMenu.Item>
        <ContextMenu.Item>
          {"Redo"->React.string}
          <ContextMenu.Shortcut> {"\u21e7\u2318Z"->React.string} </ContextMenu.Shortcut>
        </ContextMenu.Item>
      </ContextMenu.Group>
      <ContextMenu.Separator />
      <ContextMenu.Group>
        <ContextMenu.Item>
          {"Cut"->React.string}
          <ContextMenu.Shortcut> {"\u2318X"->React.string} </ContextMenu.Shortcut>
        </ContextMenu.Item>
        <ContextMenu.Item>
          {"Copy"->React.string}
          <ContextMenu.Shortcut> {"\u2318C"->React.string} </ContextMenu.Shortcut>
        </ContextMenu.Item>
        <ContextMenu.Item>
          {"Paste"->React.string}
          <ContextMenu.Shortcut> {"\u2318V"->React.string} </ContextMenu.Shortcut>
        </ContextMenu.Item>
      </ContextMenu.Group>
      <ContextMenu.Separator />
      <ContextMenu.Group>
        <ContextMenu.Item variant=ContextMenu.Variant.Destructive>
          {"Delete"->React.string}
          <ContextMenu.Shortcut> {"\u232b"->React.string} </ContextMenu.Shortcut>
        </ContextMenu.Item>
      </ContextMenu.Group>
    </ContextMenu.Content>
  </ContextMenu>
