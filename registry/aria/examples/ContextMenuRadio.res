@@directive("'use client'")

let firstKey = (selection, fallback) =>
  switch selection {
  | ReactAria.Common.Keys(keys) =>
    keys->Set.values->Iterator.toArray->Array.get(0)->Option.getOr(fallback)
  | ReactAria.Common.All => fallback
  }

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (user, setUser) = React.useState(() => "pedro")
  let (theme, setTheme) = React.useState(() => "light")
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
      <ContextMenu.Group>
        <ContextMenu.Label> {"People"->React.string} </ContextMenu.Label>
        <ContextMenu.Group
          selectionMode=Single
          selectedKeys={[user]}
          onSelectionChange={selection => setUser(_ => firstKey(selection, "pedro"))}
        >
          <ContextMenu.Item id="pedro"> {"Pedro Duarte"->React.string} </ContextMenu.Item>
          <ContextMenu.Item id="colm"> {"Colm Tuite"->React.string} </ContextMenu.Item>
        </ContextMenu.Group>
      </ContextMenu.Group>
      <ContextMenu.Separator />
      <ContextMenu.Group>
        <ContextMenu.Label> {"Theme"->React.string} </ContextMenu.Label>
        <ContextMenu.Group
          selectionMode=Single
          selectedKeys={[theme]}
          onSelectionChange={selection => setTheme(_ => firstKey(selection, "light"))}
        >
          <ContextMenu.Item id="light"> {"Light"->React.string} </ContextMenu.Item>
          <ContextMenu.Item id="dark"> {"Dark"->React.string} </ContextMenu.Item>
          <ContextMenu.Item id="system"> {"System"->React.string} </ContextMenu.Item>
        </ContextMenu.Group>
      </ContextMenu.Group>
    </ContextMenu>
  </ContextMenu.Trigger>
}
