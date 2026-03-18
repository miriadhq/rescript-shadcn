module LucideIcons = {
  type props = {className?: string, @as("data-icon") dataIcon?: string}

  module CircleFadingArrowUp = {
    @module("lucide-react")
    external make: React.component<props> = "CircleFadingArrowUpIcon"
  }
}

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Button variant=Button.Variant.Outline size=Button.Size.Icon>
    <LucideIcons.CircleFadingArrowUp />
  </Button>
