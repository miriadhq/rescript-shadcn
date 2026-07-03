@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex w-full max-w-md flex-col gap-12">
    <Bubble variant=Muted>
      <Bubble.Content> {"Classname parity is passing."->React.string} </Bubble.Content>
      <Bubble.Reactions role="img" ariaLabel="Reactions: thumbs up and fire">
        <span> {"+1"->React.string} </span>
        <span> {"reviewed"->React.string} </span>
      </Bubble.Reactions>
    </Bubble>
    <Bubble align=End>
      <Bubble.Content> {"Run the pixel test too."->React.string} </Bubble.Content>
      <Bubble.Reactions side=Top align=Start>
        <Button variant=Secondary size=IconXs ariaLabel="Thumbs up">
          <Icons.Check />
        </Button>
      </Bubble.Reactions>
    </Bubble>
  </div>
