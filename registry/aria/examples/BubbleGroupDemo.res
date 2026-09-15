@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex w-full max-w-sm flex-col gap-8 py-12">
    <Bubble variant=Muted>
      <Bubble.Content> {"Can you tell me what's the issue?"->React.string} </Bubble.Content>
    </Bubble>
    <Bubble.Group>
      <Bubble align=End>
        <Bubble.Content> {"You tell me!"->React.string} </Bubble.Content>
      </Bubble>
      <Bubble align=End>
        <Bubble.Content> {"It worked yesterday. You broke it!"->React.string} </Bubble.Content>
      </Bubble>
      <Bubble align=End>
        <Bubble.Content> {"Find the bug and fix it."->React.string} </Bubble.Content>
        <Bubble.Reactions ariaLabel="Reactions: eyes" align=Start>
          <span> {"👀"->React.string} </span>
        </Bubble.Reactions>
      </Bubble>
    </Bubble.Group>
    <Bubble variant=Muted>
      <Bubble.Content>
        {"Want me to diff yesterday's you against today's you? It's a bit embarrassing."->React.string}
      </Bubble.Content>
    </Bubble>
  </div>
