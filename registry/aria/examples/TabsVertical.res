@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Tabs defaultSelectedKey="account" orientation=Vertical>
    <Tabs.List>
      <Tabs.Trigger id="account"> {"Account"->React.string} </Tabs.Trigger>
      <Tabs.Trigger id="password"> {"Password"->React.string} </Tabs.Trigger>
      <Tabs.Trigger id="notifications"> {"Notifications"->React.string} </Tabs.Trigger>
    </Tabs.List>
  </Tabs>
