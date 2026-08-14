@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <ContextMenu.Trigger
    className="flex aspect-video w-full max-w-xs items-center justify-center rounded-xl border border-dashed text-sm"
  >
    <span className="hidden pointer-fine:inline-block"> {"Right click here"->React.string} </span>
    <span className="hidden pointer-coarse:inline-block"> {"Long press here"->React.string} </span>

    <ContextMenu>
      <ContextMenu.Group>
        <ContextMenu.Item> {"Back"->React.string} </ContextMenu.Item>
        <ContextMenu.Item isDisabled={true}> {"Forward"->React.string} </ContextMenu.Item>
        <ContextMenu.Item> {"Reload"->React.string} </ContextMenu.Item>
      </ContextMenu.Group>
    </ContextMenu>
  </ContextMenu.Trigger>
