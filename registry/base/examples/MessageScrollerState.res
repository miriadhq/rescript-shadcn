@@directive("'use client'")

let messages: array<MessageScrollerExample.message> = Array.fromInitializer(~length=12, index => {
  let number = index + 1
  let isUser = mod(index, 2) == 0

  (
    {
      id: `state-${number->Int.toString}`,
      role: isUser ? User : Assistant,
      text: isUser
        ? `Check section ${number->Int.toString} of the transcript.`
        : `Section ${number->Int.toString} is ready. Scroll state updates without rerendering the rows.`,
    }: MessageScrollerExample.message
  )
})

module StatusBar = {
  type statusProps = {...JsxDOM.domProps, @as("data-on") dataOn: bool}
  @react.component
  let make = () => {
    let {start, end} = MessageScroller.useMessageScrollerScrollable()
    let states = [
      ("At top", !start),
      ("At bottom", !end),
      ("Older above", start),
      ("Newer below", end),
    ]
    <div className="pointer-events-none absolute inset-x-3 top-3 z-10 flex flex-wrap gap-1.5">
      {states
      ->Array.map(((label, on_)) => {
        let props: statusProps = {
          dataOn: on_,
          className: "rounded-full border bg-background px-2 py-0.5 text-xs text-muted-foreground data-[on=true]:border-transparent data-[on=true]:bg-primary data-[on=true]:text-primary-foreground",
        }
        <span {...(props :> JsxDOM.domProps)} key=label> {label->React.string} </span>
      })
      ->React.array}
    </div>
  }
}

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Card className="mx-auto h-112 w-full max-w-md gap-0">
    <Card.Header className="border-b">
      <Card.Title> {"Scroll State"->React.string} </Card.Title>
      <Card.Description>
        {"Read scroll state in JavaScript with the state hook."->React.string}
      </Card.Description>
    </Card.Header>
    <Card.Content className="min-h-0 flex-1 p-0">
      <MessageScroller.Provider defaultScrollPosition=Start>
        <MessageScroller>
          <StatusBar />
          <MessageScroller.Viewport>
            <MessageScroller.Content className="gap-4 p-4 pt-12">
              {messages
              ->Array.map(message =>
                <MessageScroller.Item
                  key=message.id messageId=message.id scrollAnchor={message.role == User}
                >
                  <Message align={message.role == User ? End : Start}>
                    <Message.Content>
                      <Bubble variant={message.role == User ? Default : Muted}>
                        <Bubble.Content> {message.text->React.string} </Bubble.Content>
                      </Bubble>
                    </Message.Content>
                  </Message>
                </MessageScroller.Item>
              )
              ->React.array}
            </MessageScroller.Content>
          </MessageScroller.Viewport>
          <MessageScroller.Button />
        </MessageScroller>
      </MessageScroller.Provider>
    </Card.Content>
  </Card>
