@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex w-full max-w-md flex-col gap-8">
    <Bubble variant=Muted>
      <Bubble.Content>
        {"I checked the registry output and found one stale dependency."->React.string}
      </Bubble.Content>
    </Bubble>
    <Bubble align=End>
      <Bubble.Content> {"Remove it and rerun the build."->React.string} </Bubble.Content>
      <Bubble.Reactions>
        <span> {"+1"->React.string} </span>
      </Bubble.Reactions>
    </Bubble>
  </div>
