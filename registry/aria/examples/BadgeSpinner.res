@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex flex-wrap gap-2">
    <Badge variant=Destructive>
      <Spinner dataIcon=InlineStart />
      {"Deleting"->React.string}
    </Badge>
    <Badge variant=Secondary>
      {"Generating"->React.string}
      <Spinner dataIcon=InlineEnd />
    </Badge>
  </div>
