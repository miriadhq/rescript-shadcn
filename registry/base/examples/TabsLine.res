@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Tabs defaultValue="overview">
    <Tabs.List variant=Tabs.Variant.Line>
      <Tabs.Trigger value="overview"> {"Overview"->React.string} </Tabs.Trigger>
      <Tabs.Trigger value="analytics"> {"Analytics"->React.string} </Tabs.Trigger>
      <Tabs.Trigger value="reports"> {"Reports"->React.string} </Tabs.Trigger>
    </Tabs.List>
  </Tabs>
