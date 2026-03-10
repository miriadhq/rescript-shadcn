@@directive("'use client'")

type notifications = {
  email: bool,
  sms: bool,
  push: bool,
}

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (notifications, setNotifications) = React.useState(() => {
    email: true,
    sms: false,
    push: true,
  })

  <DropdownMenu>
    <DropdownMenu.Trigger
      render={<Button variant=Button.Variant.Outline dataSlot="dropdown-menu-trigger" />}
    >
      {"Notifications"->React.string}
    </DropdownMenu.Trigger>
    <DropdownMenu.Content className="w-48">
      <DropdownMenu.Group>
        <DropdownMenu.Label> {"Notification Preferences"->React.string} </DropdownMenu.Label>
        <DropdownMenu.CheckboxItem
          checked={notifications.email}
          onCheckedChange={(v, _) => setNotifications(n => {...n, email: v})}
        >
          <Icons.Mail />
          {"Email notifications"->React.string}
        </DropdownMenu.CheckboxItem>
        <DropdownMenu.CheckboxItem
          checked={notifications.sms}
          onCheckedChange={(v, _) => setNotifications(n => {...n, sms: v})}
        >
          <Icons.MessageSquare />
          {"SMS notifications"->React.string}
        </DropdownMenu.CheckboxItem>
        <DropdownMenu.CheckboxItem
          checked={notifications.push}
          onCheckedChange={(v, _) => setNotifications(n => {...n, push: v})}
        >
          <Icons.Bell />
          {"Push notifications"->React.string}
        </DropdownMenu.CheckboxItem>
      </DropdownMenu.Group>
    </DropdownMenu.Content>
  </DropdownMenu>
}
