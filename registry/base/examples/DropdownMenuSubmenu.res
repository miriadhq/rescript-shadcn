@@directive("'use client'")

@react.component
let make = () =>
  <DropdownMenu>
    <DropdownMenu.Trigger
      render={<Button variant=Button.Variant.Outline dataSlot="dropdown-menu-trigger" />}
    >
      {"Open"->React.string}
    </DropdownMenu.Trigger>
    <DropdownMenu.Content>
      <DropdownMenu.Group>
        <DropdownMenu.Item> {"Team"->React.string} </DropdownMenu.Item>
        <DropdownMenu.Sub>
          <DropdownMenu.SubTrigger> {"Invite users"->React.string} </DropdownMenu.SubTrigger>
          <DropdownMenu.Portal>
            <DropdownMenu.SubContent>
              <DropdownMenu.Item> {"Email"->React.string} </DropdownMenu.Item>
              <DropdownMenu.Item> {"Message"->React.string} </DropdownMenu.Item>
              <DropdownMenu.Sub>
                <DropdownMenu.SubTrigger> {"More options"->React.string} </DropdownMenu.SubTrigger>
                <DropdownMenu.Portal>
                  <DropdownMenu.SubContent>
                    <DropdownMenu.Item> {"Calendly"->React.string} </DropdownMenu.Item>
                    <DropdownMenu.Item> {"Slack"->React.string} </DropdownMenu.Item>
                    <DropdownMenu.Separator />
                    <DropdownMenu.Item> {"Webhook"->React.string} </DropdownMenu.Item>
                  </DropdownMenu.SubContent>
                </DropdownMenu.Portal>
              </DropdownMenu.Sub>
              <DropdownMenu.Separator />
              <DropdownMenu.Item> {"Advanced..."->React.string} </DropdownMenu.Item>
            </DropdownMenu.SubContent>
          </DropdownMenu.Portal>
        </DropdownMenu.Sub>
        <DropdownMenu.Item>
          {"New Team"->React.string}
          <DropdownMenu.Shortcut> {"⌘+T"->React.string} </DropdownMenu.Shortcut>
        </DropdownMenu.Item>
      </DropdownMenu.Group>
    </DropdownMenu.Content>
  </DropdownMenu>
