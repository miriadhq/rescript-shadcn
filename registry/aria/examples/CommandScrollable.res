@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (open_, setOpen) = React.useState(() => false)

  <div className="flex flex-col gap-4">
    <Button onClick={_ => setOpen(_ => true)} variant=Outline className="w-fit">
      {"Open Menu"->React.string}
    </Button>
    <Command.Dialog open_={open_} onOpenChange={(v, _) => setOpen(_ => v)}>
      <Command>
        <Command.Input placeholder="Type a command or search..." />
        <Command.List>
          <Command.Empty> {"No results found."->React.string} </Command.Empty>
          <Command.Group heading="Navigation">
            <Command.Item>
              <Icons.Home />
              <span> {"Home"->React.string} </span>
              <Command.Shortcut> {"⌘H"->React.string} </Command.Shortcut>
            </Command.Item>
            <Command.Item>
              <Icons.Inbox />
              <span> {"Inbox"->React.string} </span>
              <Command.Shortcut> {"⌘I"->React.string} </Command.Shortcut>
            </Command.Item>
            <Command.Item>
              <Icons.FileText />
              <span> {"Documents"->React.string} </span>
              <Command.Shortcut> {"⌘D"->React.string} </Command.Shortcut>
            </Command.Item>
            <Command.Item>
              <Icons.Folder />
              <span> {"Folders"->React.string} </span>
              <Command.Shortcut> {"⌘F"->React.string} </Command.Shortcut>
            </Command.Item>
          </Command.Group>
          <Command.Separator />
          <Command.Group heading="Actions">
            <Command.Item>
              <Icons.Plus />
              <span> {"New File"->React.string} </span>
              <Command.Shortcut> {"⌘N"->React.string} </Command.Shortcut>
            </Command.Item>
            <Command.Item>
              <Icons.FolderPlus />
              <span> {"New Folder"->React.string} </span>
              <Command.Shortcut> {"⇧⌘N"->React.string} </Command.Shortcut>
            </Command.Item>
            <Command.Item>
              <Icons.Copy />
              <span> {"Copy"->React.string} </span>
              <Command.Shortcut> {"⌘C"->React.string} </Command.Shortcut>
            </Command.Item>
            <Command.Item>
              <Icons.Scissors />
              <span> {"Cut"->React.string} </span>
              <Command.Shortcut> {"⌘X"->React.string} </Command.Shortcut>
            </Command.Item>
            <Command.Item>
              <Icons.ClipboardPaste />
              <span> {"Paste"->React.string} </span>
              <Command.Shortcut> {"⌘V"->React.string} </Command.Shortcut>
            </Command.Item>
            <Command.Item>
              <Icons.Trash />
              <span> {"Delete"->React.string} </span>
              <Command.Shortcut> {"⌫"->React.string} </Command.Shortcut>
            </Command.Item>
          </Command.Group>
          <Command.Separator />
          <Command.Group heading="View">
            <Command.Item>
              <Icons.LayoutGrid />
              <span> {"Grid View"->React.string} </span>
            </Command.Item>
            <Command.Item>
              <Icons.List />
              <span> {"List View"->React.string} </span>
            </Command.Item>
            <Command.Item>
              <Icons.ZoomIn />
              <span> {"Zoom In"->React.string} </span>
              <Command.Shortcut> {"⌘+"->React.string} </Command.Shortcut>
            </Command.Item>
            <Command.Item>
              <Icons.ZoomOut />
              <span> {"Zoom Out"->React.string} </span>
              <Command.Shortcut> {"⌘-"->React.string} </Command.Shortcut>
            </Command.Item>
          </Command.Group>
          <Command.Separator />
          <Command.Group heading="Account">
            <Command.Item>
              <Icons.User />
              <span> {"Profile"->React.string} </span>
              <Command.Shortcut> {"⌘P"->React.string} </Command.Shortcut>
            </Command.Item>
            <Command.Item>
              <Icons.CreditCard />
              <span> {"Billing"->React.string} </span>
              <Command.Shortcut> {"⌘B"->React.string} </Command.Shortcut>
            </Command.Item>
            <Command.Item>
              <Icons.Settings />
              <span> {"Settings"->React.string} </span>
              <Command.Shortcut> {"⌘S"->React.string} </Command.Shortcut>
            </Command.Item>
            <Command.Item>
              <Icons.Bell />
              <span> {"Notifications"->React.string} </span>
            </Command.Item>
            <Command.Item>
              <Icons.HelpCircle />
              <span> {"Help & Support"->React.string} </span>
            </Command.Item>
          </Command.Group>
          <Command.Separator />
          <Command.Group heading="Tools">
            <Command.Item>
              <Icons.Calculator />
              <span> {"Calculator"->React.string} </span>
            </Command.Item>
            <Command.Item>
              <Icons.Calendar />
              <span> {"Calendar"->React.string} </span>
            </Command.Item>
            <Command.Item>
              <Icons.Image />
              <span> {"Image Editor"->React.string} </span>
            </Command.Item>
            <Command.Item>
              <Icons.Code />
              <span> {"Code Editor"->React.string} </span>
            </Command.Item>
          </Command.Group>
        </Command.List>
      </Command>
    </Command.Dialog>
  </div>
}
