let assistantMarkdown = `Ghost bubbles work for assistant text, **markdown**, and other content that should not be framed.

This is perfect for assistant messages that should not have a frame and can take the full width of the container. You can also render \`code\` in it.

Ghost bubbles are full width and can take the full width of the container.
`

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex w-full max-w-sm flex-col gap-8 py-12">
    <Bubble align=End variant=Muted>
      <Bubble.Content>
        <Markdown> {"Hello! Are you actually **thinking**?"->React.string} </Markdown>
      </Bubble.Content>
    </Bubble>
    <Bubble variant=Ghost>
      <Bubble.Content>
        <Markdown> {assistantMarkdown->React.string} </Markdown>
      </Bubble.Content>
    </Bubble>
  </div>
