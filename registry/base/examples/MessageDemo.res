@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex w-full max-w-md flex-col gap-8">
    <Message align=End>
      <Message.Content>
        <Bubble>
          <Bubble.Content> {"Deploying to prod real quick."->React.string} </Bubble.Content>
        </Bubble>
      </Message.Content>
    </Message>
    <Message>
      <Message.Content>
        <Bubble variant=Muted>
          <Bubble.Content> {"It's 4:55 PM. On a Friday."->React.string} </Bubble.Content>
        </Bubble>
      </Message.Content>
    </Message>
    <Message align=End>
      <Message.Content>
        <Bubble>
          <Bubble.Content> {"It's a one-line change."->React.string} </Bubble.Content>
        </Bubble>
      </Message.Content>
    </Message>
  </div>
