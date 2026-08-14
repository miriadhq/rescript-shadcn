@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Tabs defaultSelectedKey="home">
    <Tabs.List>
      <Tabs.Trigger id="home"> {"Home"->React.string} </Tabs.Trigger>
      <Tabs.Trigger id="settings" isDisabled={true}> {"Disabled"->React.string} </Tabs.Trigger>
    </Tabs.List>
  </Tabs>
