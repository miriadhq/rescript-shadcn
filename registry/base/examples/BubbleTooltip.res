@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex w-full max-w-sm flex-col gap-4 py-12">
    <Bubble variant=Secondary>
      <Bubble.Content> {"Did you remove the stale route?"->React.string} </Bubble.Content>
    </Bubble>
    <Bubble align=End>
      <Bubble.Content> {"Yes, removed it from the registry."->React.string} </Bubble.Content>
      <Bubble.Reactions>
        <Tooltip>
          <Tooltip.Trigger render={<Button variant=Ghost size=IconXs />}>
            <Icons.Check />
          </Tooltip.Trigger>
          <Tooltip.Content> {"Read on Jan 5, 2026 at 4:32 PM"->React.string} </Tooltip.Content>
        </Tooltip>
      </Bubble.Reactions>
    </Bubble>
  </div>
