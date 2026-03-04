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
          <Icons.Pencil />
          {"Edit"->React.string}
        </ContextMenu.Item>
        <ContextMenu.Item>
          <Icons.Share />
          {"Share"->React.string}
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
