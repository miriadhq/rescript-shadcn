@@directive("'use client'")

@react.component
let make = () => {
  let (user, setUser) = React.useState(() => "benoit")
  let (theme, setTheme) = React.useState(() => "system")

  <Menubar className="w-72">
    <Menubar.Menu>
      <Menubar.Trigger> {"Profiles"->React.string} </Menubar.Trigger>
      <Menubar.Content>
        <Menubar.RadioGroup value={user} onValueChange={(v, _) => setUser(_ => v)}>
          <Menubar.RadioItem value="andy"> {"Andy"->React.string} </Menubar.RadioItem>
          <Menubar.RadioItem value="benoit"> {"Benoit"->React.string} </Menubar.RadioItem>
          <Menubar.RadioItem value="luis"> {"Luis"->React.string} </Menubar.RadioItem>
        </Menubar.RadioGroup>
        <Menubar.Separator />
        <Menubar.Item inset=true> {"Edit..."->React.string} </Menubar.Item>
        <Menubar.Item inset=true> {"Add Profile..."->React.string} </Menubar.Item>
      </Menubar.Content>
    </Menubar.Menu>
    <Menubar.Menu>
      <Menubar.Trigger> {"Theme"->React.string} </Menubar.Trigger>
      <Menubar.Content>
        <Menubar.RadioGroup value={theme} onValueChange={(v, _) => setTheme(_ => v)}>
          <Menubar.RadioItem value="light"> {"Light"->React.string} </Menubar.RadioItem>
          <Menubar.RadioItem value="dark"> {"Dark"->React.string} </Menubar.RadioItem>
          <Menubar.RadioItem value="system"> {"System"->React.string} </Menubar.RadioItem>
        </Menubar.RadioGroup>
      </Menubar.Content>
    </Menubar.Menu>
  </Menubar>
}
