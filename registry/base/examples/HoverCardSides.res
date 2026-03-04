let hoverCardSides = [
  (BaseUi.Types.Side.Left, "Left"),
  (BaseUi.Types.Side.Top, "Top"),
  (BaseUi.Types.Side.Bottom, "Bottom"),
  (BaseUi.Types.Side.Right, "Right"),
]

@react.component
let make = () =>
  <div className="flex flex-wrap justify-center gap-2">
    {hoverCardSides
    ->Array.map(((side, label)) =>
      <HoverCard key=label>
        <HoverCard.Trigger
          delay={100.}
          closeDelay={100.}
          render={<Button variant=Button.Variant.Outline className="capitalize" />}
        >
          {label->React.string}
        </HoverCard.Trigger>
        <HoverCard.Content side>
          <div className="flex flex-col gap-1">
            <h4 className="font-medium"> {"Hover Card"->React.string} </h4>
            <p> {`This hover card appears on the ${label} side of the trigger.`->React.string} </p>
          </div>
        </HoverCard.Content>
      </HoverCard>
    )
    ->React.array}
  </div>
