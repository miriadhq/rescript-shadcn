@@directive("'use client'")

let messages: array<MessageScrollerExample.message> = [
  {id: "vis-brief", role: User, text: "Review the incident handoff and tell me what to read first."},
  {id: "vis-brief-answer", role: Assistant, text: "Start with the summary and the impact section. The regression affected the upload queue, but the recovery path completed for every queued job."},
  {id: "vis-impact", role: User, text: "What was the customer impact?"},
  {id: "vis-impact-answer", role: Assistant, text: "Impact was limited to delayed processing.\n\nNo records were dropped, and the reconciliation worker confirmed each retry batch. Support saw confusion from two customers, but there were no checkout or billing errors."},
  {id: "vis-actions", role: User, text: "What actions are open?"},
  {id: "vis-actions-answer", role: Assistant, text: "Keep the retry window enabled until the next deploy, then add a queue-depth alert as the long-term fix.\n\nThe alert should fire on sustained queue growth, not a single short spike."},
  {id: "vis-checklist", role: User, text: "Give me the follow-up checklist."},
  {id: "vis-checklist-answer", role: Assistant, text: "After that, compare the queue recovery graph with the deploy timeline so the handoff shows exactly when processing returned to baseline.\n\nI would also add a short owner note beside each follow-up item.\n\nKeep the retry window enabled until the next deploy, then add a queue-depth alert as the long-term fix."},
]

let userMessages = messages->Array.filter(message => message.role == User)
let trimmed = text => text->String.length > 42 ? `${text->String.slice(~start=0, ~end=39)}...` : text

module Outline = {
  @react.component
  let make = () => {
    let {scrollToMessage} = MessageScroller.useMessageScroller()
    let {currentAnchorId} = MessageScroller.useMessageScrollerVisibility()
    let currentAnchorId = currentAnchorId->Nullable.toOption
    <Popover.Trigger>
      <ReactAria.Button
        ariaLabel="Open transcript outline"
        className="flex h-9 w-9 flex-col items-center justify-center gap-1 rounded-md transition-colors outline-none focus-visible:ring-3 focus-visible:ring-ring/50"
      >
        {userMessages
        ->Array.map(message =>
          <span
            key={message.id}
            className={`h-0.5 w-4 rounded-full ${currentAnchorId == Some(message.id)
                ? "bg-foreground"
                : "bg-muted-foreground/40"}`}
          />
        )
        ->React.array}
      </ReactAria.Button>
      <Popover
        placement=ReactAria.Common.Left
        offset={-28.}
        className="flex w-64 flex-col gap-1 rounded-2xl p-1"
      >
        {userMessages
        ->Array.map(message =>
          <button
            key={message.id}
            type_="button"
            ariaCurrent=?{currentAnchorId == Some(message.id) ? Some(#location) : None}
            className="flex min-h-7 items-center rounded-xl px-2 py-1.5 text-left text-sm transition-colors outline-none hover:bg-accent hover:text-accent-foreground focus-visible:bg-accent focus-visible:text-accent-foreground aria-current:bg-accent aria-current:text-accent-foreground"
            onClick={_ =>
              scrollToMessage(message.id, Some({align: Start, behavior: Smooth}))->ignore}
          >
            <span className="line-clamp-1 min-w-0">
              {message.text->trimmed->React.string}
            </span>
          </button>
        )
        ->React.array}
      </Popover>
    </Popover.Trigger>
  }
}

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <MessageScroller.Provider scrollMargin=12.>
    <div className="relative flex flex-col gap-4">
      <div className="relative mx-auto w-full max-w-sm">
        <Card className="h-140 w-full gap-0">
          <Card.Header className="gap-1 border-b">
            <Card.Title> {"Transcript Outline"->React.string} </Card.Title>
            <Card.Description> {"Track the current anchored turn."->React.string} </Card.Description>
          </Card.Header>
          <Card.Content className="flex-1 overflow-hidden p-0">
            <MessageScroller>
              <MessageScroller.Viewport>
                <MessageScroller.Content className="p-(--card-spacing)">
                  <MessageScrollerExample.Transcript messages />
                </MessageScroller.Content>
              </MessageScroller.Viewport>
              <MessageScroller.Button />
            </MessageScroller>
          </Card.Content>
        </Card>
        <div className="absolute top-1/2 -right-12 -translate-y-1/2"> <Outline /> </div>
      </div>
      <div className="mx-auto max-w-sm px-0.5 text-center text-xs text-muted-foreground">
        {"Open the outline to jump between anchored turns as you read."->React.string}
      </div>
    </div>
  </MessageScroller.Provider>
