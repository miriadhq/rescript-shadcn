@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <DropdownMenu.Trigger>
    <Button variant=Outline> {"Open"->React.string} </Button>
    <DropdownMenu>
      <DropdownMenu.Group>
        <DropdownMenu.Item> {"Team"->React.string} </DropdownMenu.Item>
        <DropdownMenu.Sub>
          <DropdownMenu.SubTrigger> {"Invite users"->React.string} </DropdownMenu.SubTrigger>

          <DropdownMenu.SubContent>
            <DropdownMenu.Item> {"Email"->React.string} </DropdownMenu.Item>
            <DropdownMenu.Item> {"Message"->React.string} </DropdownMenu.Item>
            <DropdownMenu.Sub>
              <DropdownMenu.SubTrigger> {"More options"->React.string} </DropdownMenu.SubTrigger>

              <DropdownMenu.SubContent>
                <DropdownMenu.Item> {"Calendly"->React.string} </DropdownMenu.Item>
                <DropdownMenu.Item> {"Slack"->React.string} </DropdownMenu.Item>
                <DropdownMenu.Separator />
                <DropdownMenu.Item> {"Webhook"->React.string} </DropdownMenu.Item>
              </DropdownMenu.SubContent>
            </DropdownMenu.Sub>
            <DropdownMenu.Separator />
            <DropdownMenu.Item> {"Advanced..."->React.string} </DropdownMenu.Item>
          </DropdownMenu.SubContent>
        </DropdownMenu.Sub>
        <DropdownMenu.Item>
          {"New Team"->React.string}
          <DropdownMenu.Shortcut> {"⌘+T"->React.string} </DropdownMenu.Shortcut>
        </DropdownMenu.Item>
      </DropdownMenu.Group>
    </DropdownMenu>
  </DropdownMenu.Trigger>
