@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex flex-col items-center gap-4">
    <Button disabled={true} size=Sm>
      <Spinner dataIcon=InlineStart />
      {"Loading..."->React.string}
    </Button>
    <Button variant=Outline disabled={true} size=Sm>
      <Spinner dataIcon=InlineStart />
      {"Please wait"->React.string}
    </Button>
    <Button variant=Secondary disabled={true} size=Sm>
      <Spinner dataIcon=InlineStart />
      {"Processing"->React.string}
    </Button>
  </div>
