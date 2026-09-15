@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (selectedKeys, setSelectedKeys) = React.useState(() => ["bookmarks-bar", "developer-tools"])
  <ContextMenu.Trigger>
    <ReactAria.Pressable>
      <div
        role="button"
        className="flex aspect-video w-full max-w-xs items-center justify-center rounded-xl border border-dashed text-sm"
      >
        <span className="hidden pointer-fine:inline-block">
          {"Right click here"->React.string}
        </span>
        <span className="hidden pointer-coarse:inline-block">
          {"Long press here"->React.string}
        </span>
      </div>
    </ReactAria.Pressable>
    <ContextMenu>
      <ContextMenu.Group
        selectionMode=Multiple
        selectedKeys
        onSelectionChange={selection =>
          switch selection {
          | ReactAria.Common.Keys(keys) => setSelectedKeys(_ => keys->Set.values->Iterator.toArray)
          | ReactAria.Common.All => ()
          }}
      >
        <ContextMenu.Item id="bookmarks-bar">
          {"Show Bookmarks Bar"->React.string}
        </ContextMenu.Item>
        <ContextMenu.Item> {"Show Full URLs"->React.string} </ContextMenu.Item>
        <ContextMenu.Item id="developer-tools">
          {"Show Developer Tools"->React.string}
        </ContextMenu.Item>
      </ContextMenu.Group>
    </ContextMenu>
  </ContextMenu.Trigger>
}
