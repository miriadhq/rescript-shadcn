@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Tabs defaultValue="home">
    <Tabs.List>
      <Tabs.Trigger value="home"> {"Home"->React.string} </Tabs.Trigger>
      <Tabs.Trigger value="settings" disabled={true}> {"Disabled"->React.string} </Tabs.Trigger>
    </Tabs.List>
  </Tabs>
