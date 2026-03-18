@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex flex-col items-center gap-4">
    <Button disabled={true} size=Button.Size.Sm>
      <Spinner dataIcon=InlineStart />
      {"Loading..."->React.string}
    </Button>
    <Button variant=Button.Variant.Outline disabled={true} size=Button.Size.Sm>
      <Spinner dataIcon=InlineStart />
      {"Please wait"->React.string}
    </Button>
    <Button variant=Button.Variant.Secondary disabled={true} size=Button.Size.Sm>
      <Spinner dataIcon=InlineStart />
      {"Processing"->React.string}
    </Button>
  </div>
