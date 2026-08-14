@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex w-full max-w-sm flex-col gap-8 py-12">
    <Bubble variant=Muted>
      <Bubble.Content>
        {"This bubble is aligned to the start. This is the default alignment."->React.string}
      </Bubble.Content>
    </Bubble>
    <Bubble align=End>
      <Bubble.Content>
        {"This bubble is aligned to the end. Use this for user messages."->React.string}
      </Bubble.Content>
    </Bubble>
  </div>
