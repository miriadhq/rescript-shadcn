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
          <Icons.Copy />
          {"Copy"->React.string}
        </ContextMenu.Item>
        <ContextMenu.Item>
          <Icons.Scissors />
          {"Cut"->React.string}
        </ContextMenu.Item>
        <ContextMenu.Item>
          <Icons.ClipboardPaste />
          {"Paste"->React.string}
        </ContextMenu.Item>
      </ContextMenu.Group>
      <ContextMenu.Separator />
      <ContextMenu.Group>
        <ContextMenu.Item variant=ContextMenu.Variant.Destructive>
          <Icons.Trash />
          {"Delete"->React.string}
        </ContextMenu.Item>
      </ContextMenu.Group>
    </ContextMenu.Content>
  </ContextMenu>
