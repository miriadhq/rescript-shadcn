module LucideIcons = {
  type props = {className?: string, @as("data-icon") dataIcon?: string}

  module Save = {
    @module("lucide-react")
    external make: React.component<props> = "SaveIcon"
  }
}

@react.component
let make = () => {
  <Tooltip>
    <Tooltip.Trigger render={<Button variant=Outline size=IconSm />}>
      <LucideIcons.Save />
    </Tooltip.Trigger>
    <Tooltip.Content className="pr-1.5">
      <div className="flex items-center gap-2">
        {"Save Changes"->React.string}
        <Kbd> {"S"->React.string} </Kbd>
      </div>
    </Tooltip.Content>
  </Tooltip>
}
