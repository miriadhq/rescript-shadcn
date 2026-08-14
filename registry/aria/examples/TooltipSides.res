let tooltipSides = [
  ReactAria.Common.Left,
  ReactAria.Common.Top,
  ReactAria.Common.Bottom,
  ReactAria.Common.Right,
]

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  <div className="flex flex-wrap gap-2">
    {tooltipSides
    ->Array.map(side =>
      <Tooltip.Trigger key={(side :> string)}>
        <Button variant=Outline className="w-fit capitalize">
          {(side :> string)->React.string}
        </Button>
        <Tooltip placement=side>
          <p> {"Add to library"->React.string} </p>
        </Tooltip>
      </Tooltip.Trigger>
    )
    ->React.array}
  </div>
}
