@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex w-full max-w-sm flex-col gap-8 py-12">
    <Message align=End>
      <Message.Content>
        <Attachment orientation=Vertical>
          <Attachment.Media variant=Image>
            <img
              src="https://images.unsplash.com/photo-1497366754035-f200968a6e72?w=900&auto=format&fit=crop&q=80"
              alt="Workspace"
            />
          </Attachment.Media>
        </Attachment>
        <Bubble>
          <Bubble.Content>
            {"Here's the image. Can you add it to the PDF? Use it for the cover page."->React.string}
          </Bubble.Content>
        </Bubble>
      </Message.Content>
    </Message>
    <Message>
      <Message.Content>
        <Bubble variant=Muted>
          <Bubble.Content>
            {"Done. Here's the PDF with the image added as the cover page."->React.string}
          </Bubble.Content>
        </Bubble>
        <Attachment>
          <Attachment.Media>
            <Icons.FileText />
          </Attachment.Media>
          <Attachment.Content>
            <Attachment.Title> {"sales-dashboard.pdf"->React.string} </Attachment.Title>
            <Attachment.Description> {"PDF · 2.4 MB"->React.string} </Attachment.Description>
          </Attachment.Content>
          <Attachment.Actions>
            <Attachment.Action
              type_=Button.Type.Button
              title="Download"
              ariaLabel="Download"
              size=IconSm
              variant=Secondary
            >
              <Icons.Download />
            </Attachment.Action>
          </Attachment.Actions>
        </Attachment>
      </Message.Content>
    </Message>
    <Message align=End>
      <Message.Content>
        <Bubble>
          <Bubble.Content> {"Thanks. Looks good."->React.string} </Bubble.Content>
        </Bubble>
      </Message.Content>
    </Message>
  </div>
