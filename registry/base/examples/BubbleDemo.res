@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex w-full max-w-sm flex-col gap-8 py-12">
    <Bubble align=End>
      <Bubble.Content> {"Hey there! what's up?"->React.string} </Bubble.Content>
    </Bubble>
    <Bubble.Group>
      <Bubble variant=Muted>
        <Bubble.Content> {"Hey! Want to see chat bubbles?"->React.string} </Bubble.Content>
      </Bubble>
      <Bubble variant=Muted>
        <Bubble.Content>
          {"I can group messages, switch sides, and keep the whole thread easy to scan."->React.string}
        </Bubble.Content>
        <Bubble.Reactions role="img" ariaLabel="Reaction: thumbs up">
          <span> {"👍"->React.string} </span>
        </Bubble.Reactions>
      </Bubble>
    </Bubble.Group>
    <Bubble align=End>
      <Bubble.Content> {"Sure. Hit me with your best demo."->React.string} </Bubble.Content>
    </Bubble>
    <Bubble variant=Muted>
      <Bubble.Content>
        {"Yes. You are reading a demo that is demoing itself. Very meta. Very on-brand."->React.string}
      </Bubble.Content>
      <Bubble.Reactions role="img" ariaLabel="Reactions: thumbs up, fire, eyes, and 2 more">
        <span> {"👍"->React.string} </span>
        <span> {"🔥"->React.string} </span>
        <span> {"👀"->React.string} </span>
        <span> {"+2"->React.string} </span>
      </Bubble.Reactions>
    </Bubble>
  </div>
