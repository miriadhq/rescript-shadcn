@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex w-full max-w-md flex-col gap-8">
    <Message align=End>
      <Message.Content>
        <Bubble>
          <Bubble.Content> {"Can you review this file?"->React.string} </Bubble.Content>
        </Bubble>
        <Attachment className="mt-2 w-full">
          <Attachment.Media>
            <Icons.FileText />
          </Attachment.Media>
          <Attachment.Content>
            <Attachment.Title> {"release-notes.md"->React.string} </Attachment.Title>
            <Attachment.Description> {"Markdown - 8 KB"->React.string} </Attachment.Description>
          </Attachment.Content>
        </Attachment>
      </Message.Content>
    </Message>
    <Message>
      <Message.Content>
        <Bubble variant=Muted>
          <Bubble.Content> {"The structure looks right. I left two comments."->React.string} </Bubble.Content>
        </Bubble>
      </Message.Content>
    </Message>
  </div>
