module LucideIcons = {
  type props = {className?: string, @as("data-icon") dataIcon?: string}

  module AppWindow = {
    @module("lucide-react")
    external make: React.component<props> = "AppWindowIcon"
  }

  module Code = {
    @module("lucide-react")
    external make: React.component<props> = "CodeIcon"
  }
}

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Tabs defaultSelectedKey="preview">
    <Tabs.List>
      <Tabs.Trigger id="preview">
        <LucideIcons.AppWindow />
        {"Preview"->React.string}
      </Tabs.Trigger>
      <Tabs.Trigger id="code">
        <LucideIcons.Code />
        {"Code"->React.string}
      </Tabs.Trigger>
    </Tabs.List>
  </Tabs>
