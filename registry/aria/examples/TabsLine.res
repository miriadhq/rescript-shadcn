@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Tabs defaultSelectedKey="overview">
    <Tabs.List variant=Line>
      <Tabs.Trigger id="overview"> {"Overview"->React.string} </Tabs.Trigger>
      <Tabs.Trigger id="analytics"> {"Analytics"->React.string} </Tabs.Trigger>
      <Tabs.Trigger id="reports"> {"Reports"->React.string} </Tabs.Trigger>
    </Tabs.List>
  </Tabs>
