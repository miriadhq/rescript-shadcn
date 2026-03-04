@@directive("'use client'")

@react.component
let make = () => {
  let (user, setUser) = React.useState(() => "pedro")
  let (theme, setTheme) = React.useState(() => "light")

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
        <ContextMenu.Label> {"People"->React.string} </ContextMenu.Label>
        <ContextMenu.RadioGroup value={user} onValueChange={(v, _) => setUser(_ => v)}>
          <ContextMenu.RadioItem value="pedro">
            {"Pedro Duarte"->React.string}
          </ContextMenu.RadioItem>
          <ContextMenu.RadioItem value="colm"> {"Colm Tuite"->React.string} </ContextMenu.RadioItem>
        </ContextMenu.RadioGroup>
      </ContextMenu.Group>
      <ContextMenu.Separator />
      <ContextMenu.Group>
        <ContextMenu.Label> {"Theme"->React.string} </ContextMenu.Label>
        <ContextMenu.RadioGroup value={theme} onValueChange={(v, _) => setTheme(_ => v)}>
          <ContextMenu.RadioItem value="light"> {"Light"->React.string} </ContextMenu.RadioItem>
          <ContextMenu.RadioItem value="dark"> {"Dark"->React.string} </ContextMenu.RadioItem>
          <ContextMenu.RadioItem value="system"> {"System"->React.string} </ContextMenu.RadioItem>
        </ContextMenu.RadioGroup>
      </ContextMenu.Group>
    </ContextMenu.Content>
  </ContextMenu>
}
