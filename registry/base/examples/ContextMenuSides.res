@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="grid w-full max-w-sm grid-cols-2 gap-4">
    <ContextMenu>
      <ContextMenu.Trigger
        className="flex aspect-video w-full max-w-xs items-center justify-center rounded-xl border border-dashed text-sm"
      >
        <span className="hidden pointer-fine:inline-block">
          {"Right click (top)"->React.string}
        </span>
        <span className="hidden pointer-coarse:inline-block">
          {"Long press (top)"->React.string}
        </span>
      </ContextMenu.Trigger>
      <ContextMenu.Content side=BaseUi.Types.Side.Top>
        <ContextMenu.Group>
          <ContextMenu.Item> {"Back"->React.string} </ContextMenu.Item>
          <ContextMenu.Item> {"Forward"->React.string} </ContextMenu.Item>
          <ContextMenu.Item> {"Reload"->React.string} </ContextMenu.Item>
        </ContextMenu.Group>
      </ContextMenu.Content>
    </ContextMenu>
    <ContextMenu>
      <ContextMenu.Trigger
        className="flex aspect-video w-full max-w-xs items-center justify-center rounded-xl border border-dashed text-sm"
      >
        <span className="hidden pointer-fine:inline-block">
          {"Right click (right)"->React.string}
        </span>
        <span className="hidden pointer-coarse:inline-block">
          {"Long press (right)"->React.string}
        </span>
      </ContextMenu.Trigger>
      <ContextMenu.Content side=BaseUi.Types.Side.Right>
        <ContextMenu.Group>
          <ContextMenu.Item> {"Back"->React.string} </ContextMenu.Item>
          <ContextMenu.Item> {"Forward"->React.string} </ContextMenu.Item>
          <ContextMenu.Item> {"Reload"->React.string} </ContextMenu.Item>
        </ContextMenu.Group>
      </ContextMenu.Content>
    </ContextMenu>
    <ContextMenu>
      <ContextMenu.Trigger
        className="flex aspect-video w-full max-w-xs items-center justify-center rounded-xl border border-dashed text-sm"
      >
        <span className="hidden pointer-fine:inline-block">
          {"Right click (bottom)"->React.string}
        </span>
        <span className="hidden pointer-coarse:inline-block">
          {"Long press (bottom)"->React.string}
        </span>
      </ContextMenu.Trigger>
      <ContextMenu.Content side=BaseUi.Types.Side.Bottom>
        <ContextMenu.Group>
          <ContextMenu.Item> {"Back"->React.string} </ContextMenu.Item>
          <ContextMenu.Item> {"Forward"->React.string} </ContextMenu.Item>
          <ContextMenu.Item> {"Reload"->React.string} </ContextMenu.Item>
        </ContextMenu.Group>
      </ContextMenu.Content>
    </ContextMenu>
    <ContextMenu>
      <ContextMenu.Trigger
        className="flex aspect-video w-full max-w-xs items-center justify-center rounded-xl border border-dashed text-sm"
      >
        <span className="hidden pointer-fine:inline-block">
          {"Right click (left)"->React.string}
        </span>
        <span className="hidden pointer-coarse:inline-block">
          {"Long press (left)"->React.string}
        </span>
      </ContextMenu.Trigger>
      <ContextMenu.Content side=BaseUi.Types.Side.Left>
        <ContextMenu.Group>
          <ContextMenu.Item> {"Back"->React.string} </ContextMenu.Item>
          <ContextMenu.Item> {"Forward"->React.string} </ContextMenu.Item>
          <ContextMenu.Item> {"Reload"->React.string} </ContextMenu.Item>
        </ContextMenu.Group>
      </ContextMenu.Content>
    </ContextMenu>
  </div>
