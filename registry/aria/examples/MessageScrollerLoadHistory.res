@@directive("'use client'")

module ToastOptions = {
  type t = {description: string}
}

@module("sonner")
external toast: (string, ToastOptions.t) => unit = "toast"

let history: array<MessageScrollerExample.MessageData.t> = [
  {
    id: "history-1",
    role: MessageScrollerExample.Role.User,
    text: "Can you summarize the incident channel?",
  },
  {
    id: "history-2",
    role: MessageScrollerExample.Role.Assistant,
    text: "The first alert was a delayed export job. It started backing up around 09:42 UTC and triggered the warning once the retry queue crossed the threshold.\n\nNo customer-facing checkout paths were affected, but exports for larger workspaces were running about 12 minutes behind.",
  },
  {id: "history-3", role: MessageScrollerExample.Role.User, text: "Was checkout affected?"},
  {
    id: "history-4",
    role: MessageScrollerExample.Role.Assistant,
    text: "No checkout errors were reported. Payment authorization, order creation, and confirmation emails stayed inside their normal latency bands.\n\nThe only elevated metric was export queue depth, which maps to analytics downloads instead of checkout.",
  },
  {
    id: "history-5",
    role: MessageScrollerExample.Role.User,
    text: "What changed in the last deploy?",
  },
  {
    id: "history-6",
    role: MessageScrollerExample.Role.Assistant,
    text: "Only the export queue worker changed. The deploy moved large CSV jobs onto the shared retry policy, which made each failed attempt hold a worker slot longer than before.\n\nThe app deploy did not include checkout, pricing, or billing API changes.",
  },
  {id: "history-7", role: MessageScrollerExample.Role.User, text: "Do we need to roll back?"},
  {
    id: "history-8",
    role: MessageScrollerExample.Role.Assistant,
    text: "Not yet. Queue depth is recovering after we reduced retry concurrency, and the oldest pending job is now under five minutes old.\n\nKeep rollback ready if the queue starts climbing again, but the current trend points toward recovery.",
  },
  {
    id: "history-9",
    role: MessageScrollerExample.Role.User,
    text: "Keep watching for customer-visible issues.",
  },
  {
    id: "history-10",
    role: MessageScrollerExample.Role.Assistant,
    text: "I will watch the queue and support tags for another 15 minutes. I am tracking export failures, delayed download requests, and any support thread that mentions missing reports.\n\nIf those stay quiet through the next batch window, we can close this as an internal degradation.",
  },
]

let initialVisibleCount = 5

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (demoKey, setDemoKey) = React.useState(() => 0)
  let (visibleCount, setVisibleCount) = React.useState(() => initialVisibleCount)
  let visibleMessages =
    history->Array.slice(~start=history->Array.length - visibleCount, ~end=history->Array.length)
  let canLoadHistory = visibleCount < history->Array.length

  <MessageScroller.Provider>
    <div className="relative flex flex-col gap-4">
      <Card className="mx-auto h-140 w-full max-w-sm gap-0">
        <Card.Header className="gap-1 border-b">
          <Card.Title> {"Load History"->React.string} </Card.Title>
          <Card.Description>
            {"Prepended messages keep your place."->React.string}
          </Card.Description>
          <Card.Action>
            <Tooltip.Trigger>
              <Button
                type_="button"
                variant=Outline
                size=Icon
                ariaLabel="Reset loaded messages"
                isDisabled={visibleCount == initialVisibleCount}
                onPress={_ => {
                  setVisibleCount(_ => initialVisibleCount)
                  setDemoKey(key => key + 1)
                }}
              >
                <Icons.RotateCw />
              </Button>
              <Tooltip>
                <p> {"Reset"->React.string} </p>
              </Tooltip>
            </Tooltip.Trigger>
          </Card.Action>
        </Card.Header>
        <Card.Content className="flex-1 overflow-hidden p-0">
          <MessageScroller key={demoKey->Int.toString}>
            <MessageScroller.Viewport>
              <MessageScroller.Content className="p-(--card-spacing)">
                <MessageScrollerExample.Transcript messages=visibleMessages />
                <MessageScroller.Item scrollAnchor=false>
                  <Marker variant=Separator>
                    <Marker.Content> {"End of Conversation"->React.string} </Marker.Content>
                  </Marker>
                </MessageScroller.Item>
              </MessageScroller.Content>
            </MessageScroller.Viewport>
            <MessageScroller.Button />
          </MessageScroller>
        </Card.Content>
        <Card.Footer className="flex flex-col items-center gap-2 border-t">
          <Button
            type_="button"
            isDisabled={!canLoadHistory}
            onPress={_ => {
              setVisibleCount(_ => history->Array.length)
              toast("History loaded", {description: "Scroll up to see earlier messages."})
            }}
            className="w-full"
            variant=Secondary
          >
            {(canLoadHistory ? "Load History" : "History Loaded")->React.string}
          </Button>
          <p className="text-xs text-muted-foreground">
            {"Restore earlier messages while keeping your place."->React.string}
          </p>
        </Card.Footer>
      </Card>
      <div
        className="mx-auto max-w-sm px-0.5 text-center text-xs text-balance text-muted-foreground"
      >
        {"Click Load History to load the entire conversation"->React.string}
      </div>
    </div>
  </MessageScroller.Provider>
}
