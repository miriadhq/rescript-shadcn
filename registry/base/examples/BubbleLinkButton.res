@@directive("'use client'")

@module("sonner") external toast: string => unit = "toast"

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex w-full max-w-sm flex-col gap-8 py-12">
    <Bubble variant=Muted>
      <Bubble.Content> {"How can I help you today?"->React.string} </Bubble.Content>
    </Bubble>
    <Bubble.Group>
      <Bubble variant=Tinted align=End>
        <Bubble.Content render={<button onClick={_ => toast("You clicked forgot password")} />}>
          {"I forgot my password"->React.string}
        </Bubble.Content>
      </Bubble>
      <Bubble variant=Tinted align=End>
        <Bubble.Content
          render={<button onClick={_ => toast("You clicked help with subscription")} />}
        >
          {"I need help with my subscription"->React.string}
        </Bubble.Content>
      </Bubble>
      <Bubble variant=Tinted align=End>
        <Bubble.Content
          render={<button onClick={_ => toast("You clicked something else. Talk to a human.")} />}
        >
          {"Something else. Talk to a human."->React.string}
        </Bubble.Content>
      </Bubble>
    </Bubble.Group>
  </div>
