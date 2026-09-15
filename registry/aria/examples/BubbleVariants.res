@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex w-full max-w-sm flex-col gap-12 py-12">
    <Bubble>
      <Bubble.Content> {"This is the default primary bubble."->React.string} </Bubble.Content>
    </Bubble>
    <Bubble variant=Secondary align=End>
      <Bubble.Content> {"This is the secondary variant."->React.string} </Bubble.Content>
    </Bubble>
    <Bubble variant=Muted>
      <Bubble.Content>
        {"This one is muted. It uses a lower emphasis color for the chat bubble."->React.string}
      </Bubble.Content>
      <Bubble.Reactions role="img" ariaLabel="Reaction: thumbs up">
        <span> {"👍"->React.string} </span>
      </Bubble.Reactions>
    </Bubble>
    <Bubble variant=Tinted align=End>
      <Bubble.Content>
        {"This one is tinted. The tint is a softer color derived from the primary color."->React.string}
      </Bubble.Content>
    </Bubble>
    <Bubble variant=Outline>
      <Bubble.Content> {"We can also use an outlined variant."->React.string} </Bubble.Content>
    </Bubble>
    <Bubble variant=Destructive align=End>
      <Bubble.Content> {"Or a destructive variant with a reaction."->React.string} </Bubble.Content>
      <Bubble.Reactions role="img" ariaLabel="Reaction: fire">
        <span> {"🔥"->React.string} </span>
      </Bubble.Reactions>
    </Bubble>
    <Bubble variant=Ghost>
      <Bubble.Content>
        <Markdown>
          {"Ghost bubbles work for assistant text, **markdown**, and other content that should not be framed.\n\nThis is perfect for assistant messages that should not have a frame and can take the full width of the container. You can also render `code` in it.\n\nGhost bubbles are full width and can take the full width of the container.\n"->React.string}
        </Markdown>
      </Bubble.Content>
    </Bubble>
  </div>
