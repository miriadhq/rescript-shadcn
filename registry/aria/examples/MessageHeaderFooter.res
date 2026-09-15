@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex w-full max-w-sm flex-col gap-8 py-12">
    <Message>
      <Message.Content>
        <Message.Header> {"Olivia"->React.string} </Message.Header>
        <Bubble variant=Muted>
          <Bubble.Content> {"I already checked the logs."->React.string} </Bubble.Content>
        </Bubble>
      </Message.Content>
    </Message>
    <Message align=End>
      <Message.Content>
        <Bubble>
          <Bubble.Content>
            {"Send the report to the team. Ping @shadcn if you need help."->React.string}
          </Bubble.Content>
        </Bubble>
        <Message.Footer>
          <div>
            {"Read"->React.string}
            <span className="font-normal"> {"Yesterday"->React.string} </span>
          </div>
        </Message.Footer>
      </Message.Content>
    </Message>
  </div>
