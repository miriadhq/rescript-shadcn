let tooltipSides = [
  ReactAria.Common.Placement.Left,
  ReactAria.Common.Placement.Top,
  ReactAria.Common.Placement.Bottom,
  ReactAria.Common.Placement.Right,
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
