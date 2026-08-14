@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex w-full max-w-sm flex-col gap-8 py-12">
    <Message>
      <Message.Content>
        <Bubble variant=Muted>
          <Bubble.Content>
            {"The install failure is coming from the workspace package."->React.string}
          </Bubble.Content>
        </Bubble>
        <Message.Footer>
          <Button variant=Ghost size=Icon ariaLabel="Copy"> <Icons.Copy /> </Button>
          <Button variant=Ghost size=Icon ariaLabel="Like"> <Icons.ThumbsUp /> </Button>
          <Button variant=Ghost size=Icon ariaLabel="Dislike"> <Icons.ThumbsDown /> </Button>
        </Message.Footer>
      </Message.Content>
    </Message>
    <Message align=End>
      <Message.Content>
        <Bubble>
          <Bubble.Content> {"Okay drop me a link. Taking a look..."->React.string} </Bubble.Content>
        </Bubble>
        <Message.Footer className="gap-2">
          <span className="font-normal text-destructive"> {"Failed to send"->React.string} </span>
          <Button variant=Ghost size=IconXs ariaLabel="Retry"> <Icons.RefreshCcw /> </Button>
        </Message.Footer>
      </Message.Content>
    </Message>
  </div>
