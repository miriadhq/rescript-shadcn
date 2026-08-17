@@directive("'use client'")

let messages: array<MessageScrollerExample.MessageData.t> = Array.fromInitializer(
  ~length=12,
  index => {
    let number = index + 1
    let isUser = mod(index, 2) == 0

    (
      {
        id: `state-${number->Int.toString}`,
        role: isUser ? MessageScrollerExample.Role.User : MessageScrollerExample.Role.Assistant,
        text: isUser
          ? `Check section ${number->Int.toString} of the transcript.`
          : `Section ${number->Int.toString} is ready. Scroll state updates without rerendering the rows.`,
      }: MessageScrollerExample.MessageData.t
    )
  },
)

module StatusBar = {
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
      ->Array.map(((label, on_)) =>
        <span
          key=label
          className={`rounded-full border px-2 py-0.5 text-xs ${on_
              ? "border-transparent bg-primary text-primary-foreground"
              : "bg-background text-muted-foreground"}`}
        >
          {label->React.string}
        </span>
      )
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
              <MessageScrollerExample.Transcript messages assistantVariant=Bubble.Variant.Muted />
            </MessageScroller.Content>
          </MessageScroller.Viewport>
          <MessageScroller.Button />
        </MessageScroller>
      </MessageScroller.Provider>
    </Card.Content>
  </Card>
