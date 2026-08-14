@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (selectedKeys, setSelectedKeys) = React.useState(() => ["bookmarks-bar", "developer-tools"])
  <ContextMenu.Trigger>
    <div
      role="button"
      className="flex aspect-[2/0.5] w-full items-center justify-center rounded-lg border text-sm"
    >
      {"Right click here"->React.string}
    </div>
    <ContextMenu>
      <ContextMenu.Group
        selectionMode=Multiple
        selectedKeys
        onSelectionChange={selection =>
          switch selection {
          | ReactAria.Common.Keys(keys) => setSelectedKeys(_ => keys->Set.values->Iterator.toArray)
          | ReactAria.Common.All => ()
          }
        }
      >
        <ContextMenu.Item id="bookmarks-bar"> {"Show Bookmarks Bar"->React.string} </ContextMenu.Item>
        <ContextMenu.Item> {"Show Full URLs"->React.string} </ContextMenu.Item>
        <ContextMenu.Item id="developer-tools">
          {"Show Developer Tools"->React.string}
        </ContextMenu.Item>
      </ContextMenu.Group>
    </ContextMenu>
  </ContextMenu.Trigger>
}
