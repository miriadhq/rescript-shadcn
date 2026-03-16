@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex gap-2">
    <Button variant=Button.Variant.Outline disabled=true>
      <Spinner dataIcon=InlineStart />
      {"Generating"->React.string}
    </Button>
    <Button variant=Button.Variant.Secondary disabled=true>
      {"Downloading"->React.string}
      <Spinner dataIcon=InlineStart />
    </Button>
  </div>
