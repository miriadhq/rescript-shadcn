@@directive("'use client'")

let messages: array<MessageScrollerExample.MessageData.t> = Array.fromInitializer(
  ~length=12,
  index => {
    let number = index + 1
    let isUser = mod(index, 2) == 0

    (
      {
        id: `scrollable-${number->Int.toString}`,
        role: isUser ? MessageScrollerExample.Role.User : MessageScrollerExample.Role.Assistant,
        text: isUser
          ? `Review scroll checkpoint ${number->Int.toString}.`
          : `Checkpoint ${number->Int.toString} is synced. The scrollable hook updates as the viewport moves.\n\nWhen the reader is at the first message, the footer should only point them down. Once they move into the middle of the transcript, it should explain that both directions are available.\n\nAt the latest message, the footer should switch again and only point them back up.`,
      }: MessageScrollerExample.MessageData.t
    )
  },
)

module Footer = {
  @react.component
  let make = () => {
    let {start, end} = MessageScroller.useMessageScrollerScrollable()
    let status = switch (start, end) {
    | (true, true) => "You can scroll both ways."
    | (false, true) => "You are at the top. You can only scroll down."
    | (true, false) => "You are at the bottom. You can only scroll up."
    | (false, false) => "All messages fit in the viewport."
    }
    <Card.Footer className="justify-center border-t text-center text-sm text-muted-foreground">
      {status->React.string}
    </Card.Footer>
  }
}

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="mx-auto flex w-full max-w-sm flex-col gap-4">
    <Card className="h-140 w-full gap-0 overflow-hidden">
      <Card.Header className="gap-1 border-b">
        <Card.Title> {"Scroll Status"->React.string} </Card.Title>
        <Card.Description>
          {"Where the reader can go scroll to based on current scroll position."->React.string}
        </Card.Description>
      </Card.Header>
      <MessageScroller.Provider defaultScrollPosition=Start>
        <Card.Content className="flex-1 overflow-hidden p-0">
          <MessageScroller>
            <MessageScroller.Viewport>
              <MessageScroller.Content className="gap-4 p-(--card-spacing)">
                <MessageScrollerExample.Transcript messages />
              </MessageScroller.Content>
            </MessageScroller.Viewport>
            <MessageScroller.Button />
          </MessageScroller>
        </Card.Content>
        <Footer />
      </MessageScroller.Provider>
    </Card>
    <div className="px-0.5 text-center text-xs text-muted-foreground">
      {"Scroll the transcript to see the footer update."->React.string}
    </div>
  </div>
