let placements = [ReactAria.Common.Left, Top, Bottom, Right]

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex flex-wrap justify-center gap-2">
    {placements
    ->Array.map(placement =>
      <HoverCard.Trigger key={(placement :> string)} delay=100 closeDelay=100>
        <Button variant=Outline className="capitalize">
          {React.string((placement :> string))}
        </Button>
        <HoverCard placement>
          <div className="flex flex-col gap-1">
            <h4 className="font-medium"> {React.string("Hover Card")} </h4>
            <p>
              {React.string(
                `This hover card appears on the ${(placement :> string)} side of the trigger.`,
              )}
            </p>
          </div>
        </HoverCard>
      </HoverCard.Trigger>
    )
    ->React.array}
  </div>
