module TablerIcons = {
  type props = {
    className?: string,
    @as("data-icon") dataIcon?: string,
  }

  module GitBranch = {
    @module("@tabler/icons-react")
    external make: React.component<props> = "IconGitBranch"
  }

  module GitFork = {
    @module("@tabler/icons-react")
    external make: React.component<props> = "IconGitFork"
  }
}

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex gap-2">
    <Button variant=Button.Variant.Outline>
      <TablerIcons.GitBranch dataIcon="inline-start" />
      {"New Branch"->React.string}
    </Button>
    <Button variant=Button.Variant.Outline>
      {"Fork"->React.string}
      <TablerIcons.GitFork dataIcon="inline-end" />
    </Button>
  </div>
