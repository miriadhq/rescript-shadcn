@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex w-full max-w-sm flex-col gap-12 py-12">
    <Bubble variant=Muted align=End>
      <Bubble.Content> {"I don't need tests, I know my code works."->React.string} </Bubble.Content>
      <Bubble.Reactions align=Start role="img" ariaLabel="Reactions: thumbs up, surprised">
        <span> {"👍"->React.string} </span>
        <span> {"😮"->React.string} </span>
      </Bubble.Reactions>
    </Bubble>
    <Bubble variant=Muted>
      <Bubble.Content>
        {"Bold. Fine I'll add some tests. I'll let you know when they're done."->React.string}
      </Bubble.Content>
      <Bubble.Reactions role="img" ariaLabel="Reactions: eyes, rocket, and 2 more">
        <span> {"👀"->React.string} </span>
        <span> {"🚀"->React.string} </span>
        <span> {"+2"->React.string} </span>
      </Bubble.Reactions>
    </Bubble>
    <Bubble variant=Default align=End>
      <Bubble.Content>
        {"Tests passed on the first try. All 142 of them. Looking good!"->React.string}
      </Bubble.Content>
      <Bubble.Reactions
        side=Top align=Start role="img" ariaLabel="Reactions: party popper, clapping hands"
      >
        <span> {"🎉"->React.string} </span>
        <span> {"👏"->React.string} </span>
      </Bubble.Reactions>
    </Bubble>
    <Bubble variant=Destructive>
      <Bubble.Content> {"Are you sure I can run this command?"->React.string} </Bubble.Content>
      <Bubble.Reactions>
        <Button
          variant=Ghost
          size=Xs
          onClick={_ => Sonner.success("You clicked yes, running command..."->React.string)}
        >
          {"Yes, run it"->React.string}
        </Button>
      </Bubble.Reactions>
    </Bubble>
  </div>
