let response = `Here's how to render markdown in a message:

1. Render assistant text through **Markdown**.
2. Keep user messages as plain text.
3. Use a \`ghost\` bubble so the response is unframed.
`

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex w-full max-w-sm flex-col gap-8 py-12">
    <Message align=End>
      <Message.Content>
        <Bubble>
          <Bubble.Content>
            {"How do I render markdown in a message?"->React.string}
          </Bubble.Content>
        </Bubble>
      </Message.Content>
    </Message>
    <Message>
      <Message.Content>
        <Bubble variant=Ghost>
          <Bubble.Content>
            <Markdown> {response->React.string} </Markdown>
          </Bubble.Content>
        </Bubble>
      </Message.Content>
    </Message>
  </div>
