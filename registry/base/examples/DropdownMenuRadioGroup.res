@@directive("'use client'")

@react.component
let make = () => {
  let (position, setPosition) = React.useState(() => "bottom")

  <DropdownMenu>
    <DropdownMenu.Trigger
      render={<Button variant=Button.Variant.Outline dataSlot="dropdown-menu-trigger" />}
    >
      {"Open"->React.string}
    </DropdownMenu.Trigger>
    <DropdownMenu.Content className="w-32">
      <DropdownMenu.Group>
        <DropdownMenu.Label> {"Panel Position"->React.string} </DropdownMenu.Label>
        <DropdownMenu.RadioGroup value={position} onValueChange={(v, _) => setPosition(_ => v)}>
          <DropdownMenu.RadioItem value="top"> {"Top"->React.string} </DropdownMenu.RadioItem>
          <DropdownMenu.RadioItem value="bottom"> {"Bottom"->React.string} </DropdownMenu.RadioItem>
          <DropdownMenu.RadioItem value="right"> {"Right"->React.string} </DropdownMenu.RadioItem>
        </DropdownMenu.RadioGroup>
      </DropdownMenu.Group>
    </DropdownMenu.Content>
  </DropdownMenu>
}
