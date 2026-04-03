@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (showStatusBar, setShowStatusBar) = React.useState(() => true)
  let (showActivityBar, setShowActivityBar) = React.useState(() => false)
  let (showPanel, setShowPanel) = React.useState(() => false)

  <DropdownMenu>
    <DropdownMenu.Trigger render={<Button variant=Outline dataSlot="dropdown-menu-trigger" />}>
      {"Open"->React.string}
    </DropdownMenu.Trigger>
    <DropdownMenu.Content className="w-40">
      <DropdownMenu.Group>
        <DropdownMenu.Label> {"Appearance"->React.string} </DropdownMenu.Label>
        <DropdownMenu.CheckboxItem
          checked={showStatusBar} onCheckedChange={(v, _) => setShowStatusBar(_ => v)}
        >
          {"Status Bar"->React.string}
        </DropdownMenu.CheckboxItem>
        <DropdownMenu.CheckboxItem
          checked={showActivityBar}
          onCheckedChange={(v, _) => setShowActivityBar(_ => v)}
          disabled={true}
        >
          {"Activity Bar"->React.string}
        </DropdownMenu.CheckboxItem>
        <DropdownMenu.CheckboxItem
          checked={showPanel} onCheckedChange={(v, _) => setShowPanel(_ => v)}
        >
          {"Panel"->React.string}
        </DropdownMenu.CheckboxItem>
      </DropdownMenu.Group>
    </DropdownMenu.Content>
  </DropdownMenu>
}
