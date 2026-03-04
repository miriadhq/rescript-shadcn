@react.component
let make = () =>
  <div className="flex flex-col items-center gap-4">
    <Button disabled={true} size=Button.Size.Sm>
      <Spinner dataIcon="inline-start" />
      {"Loading..."->React.string}
    </Button>
    <Button variant=Button.Variant.Outline disabled={true} size=Button.Size.Sm>
      <Spinner dataIcon="inline-start" />
      {"Please wait"->React.string}
    </Button>
    <Button variant=Button.Variant.Secondary disabled={true} size=Button.Size.Sm>
      <Spinner dataIcon="inline-start" />
      {"Processing"->React.string}
    </Button>
  </div>
