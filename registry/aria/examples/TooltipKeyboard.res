module LucideIcons = {
  type props = {className?: string, @as("data-icon") dataIcon?: string}

  module Save = {
    @module("lucide-react")
    external make: React.component<props> = "SaveIcon"
  }
}

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  <Tooltip.Trigger>
    <Button variant=Outline size=IconSm>
      <LucideIcons.Save />
    </Button>
    <Tooltip className="pr-1.5">
      <div className="flex items-center gap-2">
        {"Save Changes"->React.string}
        <Kbd> {"S"->React.string} </Kbd>
      </div>
    </Tooltip>
  </Tooltip.Trigger>
}
