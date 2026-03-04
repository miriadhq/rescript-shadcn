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
        <ContextMenu.CheckboxItem defaultChecked={true}>
          {"Show Bookmarks Bar"->React.string}
        </ContextMenu.CheckboxItem>
        <ContextMenu.CheckboxItem> {"Show Full URLs"->React.string} </ContextMenu.CheckboxItem>
        <ContextMenu.CheckboxItem defaultChecked={true}>
          {"Show Developer Tools"->React.string}
        </ContextMenu.CheckboxItem>
      </ContextMenu.Group>
    </ContextMenu.Content>
  </ContextMenu>
