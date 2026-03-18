let tooltipSides = [
  BaseUi.Types.Side.Left,
  BaseUi.Types.Side.Top,
  BaseUi.Types.Side.Bottom,
  BaseUi.Types.Side.Right,
]

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  <div className="flex flex-wrap gap-2">
    {tooltipSides
    ->Array.map(side =>
      <Tooltip key={(side :> string)}>
        <Tooltip.Trigger render={<Button variant=Outline className="w-fit capitalize" />}>
          {(side :> string)->React.string}
        </Tooltip.Trigger>
        <Tooltip.Content side>
          <p> {"Add to library"->React.string} </p>
        </Tooltip.Content>
      </Tooltip>
    )
    ->React.array}
  </div>
}
