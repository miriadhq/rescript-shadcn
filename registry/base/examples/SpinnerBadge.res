@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex items-center gap-4 [--radius:1.2rem]">
    <Badge>
      <Spinner dataIcon=InlineStart />
      {"Syncing"->React.string}
    </Badge>
    <Badge variant=Secondary>
      <Spinner dataIcon=InlineStart />
      {"Updating"->React.string}
    </Badge>
    <Badge variant=Outline>
      <Spinner dataIcon=InlineStart />
      {"Processing"->React.string}
    </Badge>
  </div>
