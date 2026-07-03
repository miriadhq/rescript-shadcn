@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex w-full max-w-md flex-col gap-8">
    <Message.Group>
      <Message>
        <Message.Content>
          <Bubble variant=Muted>
            <Bubble.Content> {"The class hooks match upstream now."->React.string} </Bubble.Content>
          </Bubble>
        </Message.Content>
      </Message>
      <Message>
        <Message.Content>
          <Bubble variant=Muted>
            <Bubble.Content> {"I also regenerated the registry."->React.string} </Bubble.Content>
          </Bubble>
        </Message.Content>
      </Message>
    </Message.Group>
    <Message align=End>
      <Message.Content>
        <Bubble>
          <Bubble.Content> {"Perfect, update the docs page."->React.string} </Bubble.Content>
        </Bubble>
      </Message.Content>
    </Message>
  </div>
