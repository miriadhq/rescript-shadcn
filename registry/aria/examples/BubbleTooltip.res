@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex w-full max-w-sm flex-col gap-4 py-12">
    <Bubble variant=Secondary>
      <Bubble.Content> {"Did you remove the stale route?"->React.string} </Bubble.Content>
    </Bubble>
    <Bubble align=End>
      <Bubble.Content> {"Yes, removed it from the registry."->React.string} </Bubble.Content>
      <Bubble.Reactions>
        <Tooltip.Trigger>
          <Button variant=Ghost size=IconXs>
            <Icons.Check />
          </Button>
          <Tooltip> {"Read on Jan 5, 2026 at 4:32 PM"->React.string} </Tooltip>
        </Tooltip.Trigger>
      </Bubble.Reactions>
    </Bubble>
  </div>
