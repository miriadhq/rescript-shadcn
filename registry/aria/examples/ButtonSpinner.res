@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex gap-2">
    <Button variant=Outline isDisabled=true>
      <Spinner dataIcon=InlineStart />
      {"Generating"->React.string}
    </Button>
    <Button variant=Secondary isDisabled=true>
      {"Downloading"->React.string}
      <Spinner dataIcon=InlineStart />
    </Button>
  </div>
