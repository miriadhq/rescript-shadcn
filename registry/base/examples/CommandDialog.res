@@directive("'use client'")

type keyboardEvent
@val external document: Dom.document = "document"
@send
external addKeyDownListener: (Dom.document, string, keyboardEvent => unit) => unit =
  "addEventListener"
@send
external removeKeyDownListener: (Dom.document, string, keyboardEvent => unit) => unit =
  "removeEventListener"
@get external eventKey: keyboardEvent => string = "key"
@get external eventMetaKey: keyboardEvent => bool = "metaKey"
@get external eventCtrlKey: keyboardEvent => bool = "ctrlKey"
@send external eventPreventDefault: keyboardEvent => unit = "preventDefault"

@react.component
let make = () => {
  let (open_, setOpen) = React.useState(() => false)

  React.useEffect(() => {
    let down = (e: keyboardEvent) => {
      if e->eventKey == "j" && (e->eventMetaKey || e->eventCtrlKey) {
        e->eventPreventDefault
        setOpen(prev => !prev)
      }
    }
    document->addKeyDownListener("keydown", down)
    Some(() => document->removeKeyDownListener("keydown", down))
  }, [])

  <>
    <p className="text-muted-foreground text-sm">
      {"Press "->React.string}
      <kbd
        className="bg-muted text-muted-foreground pointer-events-none inline-flex h-5 items-center gap-1 rounded border px-1.5 font-mono text-[10px] font-medium opacity-100 select-none"
      >
        <span className="text-xs"> {"⌘"->React.string} </span>
        {"J"->React.string}
      </kbd>
    </p>
    <Command.Dialog open_={open_} onOpenChange={(v, _) => setOpen(_ => v)}>
      <Command.Input placeholder="Type a command or search..." />
      <Command.List>
        <Command.Empty> {"No results found."->React.string} </Command.Empty>
        <Command.Group heading="Suggestions">
          <Command.Item>
            <Icons.Calendar />
            <span> {"Calendar"->React.string} </span>
          </Command.Item>
          <Command.Item>
            <Icons.Smile />
            <span> {"Search Emoji"->React.string} </span>
          </Command.Item>
          <Command.Item>
            <Icons.Calculator />
            <span> {"Calculator"->React.string} </span>
          </Command.Item>
        </Command.Group>
        <Command.Separator />
        <Command.Group heading="Settings">
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
        </Command.Group>
      </Command.List>
    </Command.Dialog>
  </>
}
