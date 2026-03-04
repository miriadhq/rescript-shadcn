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
        <ContextMenu.Item>
          {"Back"->React.string}
          <ContextMenu.Shortcut> {"\u2318["->React.string} </ContextMenu.Shortcut>
        </ContextMenu.Item>
        <ContextMenu.Item disabled={true}>
          {"Forward"->React.string}
          <ContextMenu.Shortcut> {"\u2318]"->React.string} </ContextMenu.Shortcut>
        </ContextMenu.Item>
        <ContextMenu.Item>
          {"Reload"->React.string}
          <ContextMenu.Shortcut> {"\u2318R"->React.string} </ContextMenu.Shortcut>
        </ContextMenu.Item>
      </ContextMenu.Group>
      <ContextMenu.Separator />
      <ContextMenu.Group>
        <ContextMenu.Item>
          {"Save"->React.string}
          <ContextMenu.Shortcut> {"\u2318S"->React.string} </ContextMenu.Shortcut>
        </ContextMenu.Item>
        <ContextMenu.Item>
          {"Save As..."->React.string}
          <ContextMenu.Shortcut> {"\u21e7\u2318S"->React.string} </ContextMenu.Shortcut>
        </ContextMenu.Item>
      </ContextMenu.Group>
    </ContextMenu.Content>
  </ContextMenu>
