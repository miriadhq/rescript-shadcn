@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex w-full max-w-md flex-col gap-8">
    <Bubble.Group>
      <Bubble variant=Muted>
        <Bubble.Content> {"I finished the audit pass."->React.string} </Bubble.Content>
      </Bubble>
      <Bubble variant=Muted>
        <Bubble.Content> {"The registry output is clean now."->React.string} </Bubble.Content>
      </Bubble>
    </Bubble.Group>
    <Bubble.Group>
      <Bubble align=End>
        <Bubble.Content> {"Great, ship that patch."->React.string} </Bubble.Content>
      </Bubble>
      <Bubble align=End>
        <Bubble.Content> {"Then update the docs."->React.string} </Bubble.Content>
      </Bubble>
    </Bubble.Group>
  </div>
