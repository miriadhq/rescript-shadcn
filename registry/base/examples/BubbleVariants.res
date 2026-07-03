@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex w-full max-w-md flex-col gap-5">
    <Bubble>
      <Bubble.Content> {"Default bubble for the current user."->React.string} </Bubble.Content>
    </Bubble>
    <Bubble variant=Secondary>
      <Bubble.Content> {"Secondary bubble for conversation content."->React.string} </Bubble.Content>
    </Bubble>
    <Bubble variant=Muted>
      <Bubble.Content> {"Muted bubble for quiet supporting details."->React.string} </Bubble.Content>
    </Bubble>
    <Bubble variant=Outline>
      <Bubble.Content> {"Outline bubble for framed content."->React.string} </Bubble.Content>
    </Bubble>
    <Bubble variant=Ghost>
      <Bubble.Content>
        <span className="whitespace-pre-wrap">
          {"Ghost bubbles work well for assistant text that should use the full row."->React.string}
        </span>
      </Bubble.Content>
    </Bubble>
  </div>
