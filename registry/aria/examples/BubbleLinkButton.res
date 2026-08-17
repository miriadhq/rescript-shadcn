@@directive("'use client'")

@module("sonner") external toast: string => unit = "toast"
@module("react")
external createElement: (string, ReactAria.Types.DomProps.t) => React.element = "createElement"

let button = (message, props: ReactAria.Types.DomProps.t) =>
  createElement("button", {...props, type_: "button", onClick: _ => toast(message)})

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex w-full max-w-sm flex-col gap-8 py-12">
    <Bubble variant=Muted>
      <Bubble.Content> {"How can I help you today?"->React.string} </Bubble.Content>
    </Bubble>
    <Bubble.Group>
      <Bubble variant=Tinted align=End>
        <Bubble.Content render={props => button("You clicked forgot password", props)}>
          {"I forgot my password"->React.string}
        </Bubble.Content>
      </Bubble>
      <Bubble variant=Tinted align=End>
        <Bubble.Content render={props => button("You clicked help with subscription", props)}>
          {"I need help with my subscription"->React.string}
        </Bubble.Content>
      </Bubble>
      <Bubble variant=Tinted align=End>
        <Bubble.Content
          render={props => button("You clicked something else. Talk to a human.", props)}
        >
          {"Something else. Talk to a human."->React.string}
        </Bubble.Content>
      </Bubble>
    </Bubble.Group>
  </div>
