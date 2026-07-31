@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex w-full max-w-md flex-col gap-8">
    <Message>
      <Message.Content>
        <Message.Header>
          <span className="text-sm font-medium"> {"Rhea"->React.string} </span>
        </Message.Header>
        <Bubble variant=Muted>
          <Bubble.Content> {"I pushed the updated registry item."->React.string} </Bubble.Content>
        </Bubble>
        <Message.Footer>
          <span className="text-xs text-muted-foreground"> {"2 minutes ago"->React.string} </span>
        </Message.Footer>
      </Message.Content>
    </Message>
    <Message align=End>
      <Message.Content>
        <Bubble>
          <Bubble.Content> {"Looks good from here."->React.string} </Bubble.Content>
        </Bubble>
        <Message.Footer>
          <Button variant=Ghost size=IconXs ariaLabel="Copy message">
            <Icons.Copy />
          </Button>
        </Message.Footer>
      </Message.Content>
    </Message>
  </div>
