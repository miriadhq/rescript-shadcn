@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Tabs defaultValue="account" orientation=Vertical>
    <Tabs.List>
      <Tabs.Trigger value="account"> {"Account"->React.string} </Tabs.Trigger>
      <Tabs.Trigger value="password"> {"Password"->React.string} </Tabs.Trigger>
      <Tabs.Trigger value="notifications"> {"Notifications"->React.string} </Tabs.Trigger>
    </Tabs.List>
  </Tabs>
