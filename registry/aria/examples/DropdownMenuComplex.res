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
  let (theme, setTheme) = React.useState(() => "light")

  <DropdownMenu.Trigger>
    <Button variant=Outline> {"Complex Menu"->React.string} </Button>
    <DropdownMenu className="w-44">
      <DropdownMenu.Group>
        <DropdownMenu.Label> {"File"->React.string} </DropdownMenu.Label>
        <DropdownMenu.Item>
          <Icons.File />
          {"New File"->React.string}
          <DropdownMenu.Shortcut> {"⌘N"->React.string} </DropdownMenu.Shortcut>
        </DropdownMenu.Item>
        <DropdownMenu.Item>
          <Icons.Folder />
          {"New Folder"->React.string}
          <DropdownMenu.Shortcut> {"⇧⌘N"->React.string} </DropdownMenu.Shortcut>
        </DropdownMenu.Item>
        <DropdownMenu.Sub>
          <DropdownMenu.SubTrigger>
            <Icons.FolderOpen />
            {"Open Recent"->React.string}
          </DropdownMenu.SubTrigger>

          <DropdownMenu.SubContent>
            <DropdownMenu.Group>
              <DropdownMenu.Label> {"Recent Projects"->React.string} </DropdownMenu.Label>
              <DropdownMenu.Item>
                <Icons.FileCode />
                {"Project Alpha"->React.string}
              </DropdownMenu.Item>
              <DropdownMenu.Item>
                <Icons.FileCode />
                {"Project Beta"->React.string}
              </DropdownMenu.Item>
              <DropdownMenu.Sub>
                <DropdownMenu.SubTrigger>
                  <Icons.MoreHorizontal />
                  {"More Projects"->React.string}
                </DropdownMenu.SubTrigger>

                <DropdownMenu.SubContent>
                  <DropdownMenu.Item>
                    <Icons.FileCode />
                    {"Project Gamma"->React.string}
                  </DropdownMenu.Item>
                  <DropdownMenu.Item>
                    <Icons.FileCode />
                    {"Project Delta"->React.string}
                  </DropdownMenu.Item>
                </DropdownMenu.SubContent>
              </DropdownMenu.Sub>
            </DropdownMenu.Group>
            <DropdownMenu.Separator />
            <DropdownMenu.Group>
              <DropdownMenu.Item>
                <Icons.FolderSearch />
                {"Browse..."->React.string}
              </DropdownMenu.Item>
            </DropdownMenu.Group>
          </DropdownMenu.SubContent>
        </DropdownMenu.Sub>
        <DropdownMenu.Separator />
        <DropdownMenu.Item>
          <Icons.Save />
          {"Save"->React.string}
          <DropdownMenu.Shortcut> {"⌘S"->React.string} </DropdownMenu.Shortcut>
        </DropdownMenu.Item>
        <DropdownMenu.Item>
          <Icons.Download />
          {"Export"->React.string}
          <DropdownMenu.Shortcut> {"⇧⌘E"->React.string} </DropdownMenu.Shortcut>
        </DropdownMenu.Item>
      </DropdownMenu.Group>
      <DropdownMenu.Separator />
      <DropdownMenu.Group
        selectionMode=Multiple
        selectedKeys={[
          notifications.email ? "sidebar" : "",
          notifications.sms ? "status" : "",
        ]->Array.filter(key => key != "")}
        onSelectionChange={selection =>
          switch selection {
          | ReactAria.Common.Keys(keys) =>
            setNotifications(value => {
              ...value,
              email: keys->Set.has("sidebar"),
              sms: keys->Set.has("status"),
            })
          | ReactAria.Common.All => ()
          }}
      >
        <DropdownMenu.Label> {"View"->React.string} </DropdownMenu.Label>
        <DropdownMenu.Item id="sidebar">
          <Icons.Eye />
          {"Show Sidebar"->React.string}
        </DropdownMenu.Item>
        <DropdownMenu.Item id="status">
          <Icons.Layout />
          {"Show Status Bar"->React.string}
        </DropdownMenu.Item>
        <DropdownMenu.Sub>
          <DropdownMenu.SubTrigger>
            <Icons.Palette />
            {"Theme"->React.string}
          </DropdownMenu.SubTrigger>

          <DropdownMenu.SubContent>
            <DropdownMenu.Group
              selectionMode=Single
              selectedKeys={[theme]}
              onSelectionChange={selection =>
                switch selection {
                | ReactAria.Common.Keys(keys) =>
                  setTheme(_ =>
                    keys->Set.values->Iterator.toArray->Array.get(0)->Option.getOr("system")
                  )
                | ReactAria.Common.All => setTheme(_ => "system")
                }}
            >
              <DropdownMenu.Label> {"Appearance"->React.string} </DropdownMenu.Label>
              <DropdownMenu.Item id="light">
                <Icons.Sun />
                {"Light"->React.string}
              </DropdownMenu.Item>
              <DropdownMenu.Item id="dark">
                <Icons.Moon />
                {"Dark"->React.string}
              </DropdownMenu.Item>
              <DropdownMenu.Item id="system">
                <Icons.Monitor />
                {"System"->React.string}
              </DropdownMenu.Item>
            </DropdownMenu.Group>
          </DropdownMenu.SubContent>
        </DropdownMenu.Sub>
      </DropdownMenu.Group>
      <DropdownMenu.Separator />
      <DropdownMenu.Group>
        <DropdownMenu.Label> {"Account"->React.string} </DropdownMenu.Label>
        <DropdownMenu.Item>
          <Icons.User />
          {"Profile"->React.string}
          <DropdownMenu.Shortcut> {"⇧⌘P"->React.string} </DropdownMenu.Shortcut>
        </DropdownMenu.Item>
        <DropdownMenu.Item>
          <Icons.CreditCard />
          {"Billing"->React.string}
        </DropdownMenu.Item>
        <DropdownMenu.Sub>
          <DropdownMenu.SubTrigger>
            <Icons.Settings />
            {"Settings"->React.string}
          </DropdownMenu.SubTrigger>

          <DropdownMenu.SubContent>
            <DropdownMenu.Group>
              <DropdownMenu.Label> {"Preferences"->React.string} </DropdownMenu.Label>
              <DropdownMenu.Item>
                <Icons.Keyboard />
                {"Keyboard Shortcuts"->React.string}
              </DropdownMenu.Item>
              <DropdownMenu.Item>
                <Icons.Languages />
                {"Language"->React.string}
              </DropdownMenu.Item>
              <DropdownMenu.Sub>
                <DropdownMenu.SubTrigger>
                  <Icons.Bell />
                  {"Notifications"->React.string}
                </DropdownMenu.SubTrigger>

                <DropdownMenu.SubContent>
                  <DropdownMenu.Group
                    selectionMode=Multiple
                    selectedKeys={[
                      notifications.push ? "push" : "",
                      notifications.email ? "email" : "",
                    ]->Array.filter(key => key != "")}
                    onSelectionChange={selection =>
                      switch selection {
                      | ReactAria.Common.Keys(keys) =>
                        setNotifications(value => {
                          ...value,
                          push: keys->Set.has("push"),
                          email: keys->Set.has("email"),
                        })
                      | ReactAria.Common.All => ()
                      }}
                  >
                    <DropdownMenu.Label> {"Notification Types"->React.string} </DropdownMenu.Label>
                    <DropdownMenu.Item id="push">
                      <Icons.Bell />
                      {"Push Notifications"->React.string}
                    </DropdownMenu.Item>
                    <DropdownMenu.Item id="email">
                      <Icons.Mail />
                      {"Email Notifications"->React.string}
                    </DropdownMenu.Item>
                  </DropdownMenu.Group>
                </DropdownMenu.SubContent>
              </DropdownMenu.Sub>
            </DropdownMenu.Group>
            <DropdownMenu.Separator />
            <DropdownMenu.Group>
              <DropdownMenu.Item>
                <Icons.Shield />
                {"Privacy & Security"->React.string}
              </DropdownMenu.Item>
            </DropdownMenu.Group>
          </DropdownMenu.SubContent>
        </DropdownMenu.Sub>
      </DropdownMenu.Group>
      <DropdownMenu.Separator />
      <DropdownMenu.Group>
        <DropdownMenu.Item>
          <Icons.HelpCircle />
          {"Help & Support"->React.string}
        </DropdownMenu.Item>
        <DropdownMenu.Item>
          <Icons.FileText />
          {"Documentation"->React.string}
        </DropdownMenu.Item>
      </DropdownMenu.Group>
      <DropdownMenu.Separator />
      <DropdownMenu.Group>
        <DropdownMenu.Item variant=Destructive>
          <Icons.LogOut />
          {"Sign Out"->React.string}
          <DropdownMenu.Shortcut> {"⇧⌘Q"->React.string} </DropdownMenu.Shortcut>
        </DropdownMenu.Item>
      </DropdownMenu.Group>
    </DropdownMenu>
  </DropdownMenu.Trigger>
}
