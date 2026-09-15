@@directive("'use client'")

type toastOptions = {description: string}

@module("sonner")
external toast: (string, toastOptions) => unit = "toast"

let history: array<MessageScrollerExample.message> = [
  {id: "msg-1", role: User, text: "Can you summarize the incident channel?"},
  {
    id: "msg-2",
    role: Assistant,
    text: "The first alert was a delayed export job. It started backing up around 09:42 UTC and triggered the warning once the retry queue crossed the threshold.\n\nNo customer-facing checkout paths were affected, but exports for larger workspaces were running about 12 minutes behind.",
  },
  {id: "msg-3", role: User, text: "Was checkout affected?"},
  {
    id: "msg-4",
    role: Assistant,
    text: "No checkout errors were reported. Payment authorization, order creation, and confirmation emails stayed inside their normal latency bands.\n\nThe only elevated metric was export queue depth, which maps to analytics downloads instead of checkout.",
  },
  {id: "msg-5", role: User, text: "What changed in the last deploy?"},
  {
    id: "msg-6",
    role: Assistant,
    text: "Only the export queue worker changed. The deploy moved large CSV jobs onto the shared retry policy, which made each failed attempt hold a worker slot longer than before.\n\nThe app deploy did not include checkout, pricing, or billing API changes.",
  },
  {id: "msg-7", role: User, text: "Do we need to roll back?"},
  {
    id: "msg-8",
    role: Assistant,
    text: "Not yet. Queue depth is recovering after we reduced retry concurrency, and the oldest pending job is now under five minutes old.\n\nKeep rollback ready if the queue starts climbing again, but the current trend points toward recovery.",
  },
  {id: "msg-9", role: User, text: "Keep watching for customer-visible issues."},
  {
    id: "msg-10",
    role: Assistant,
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
            <Tooltip>
              <Tooltip.Trigger
                render={<Button
                  type_=Button
                  variant=Outline
                  size=Icon
                  ariaLabel="Reset loaded messages"
                  disabled={visibleCount == initialVisibleCount}
                  onClick={_ => {
                    setVisibleCount(_ => initialVisibleCount)
                    setDemoKey(key => key + 1)
                  }}
                />}
              >
                <Icons.RotateCw />
              </Tooltip.Trigger>
              <Tooltip.Content>
                <p> {"Reset"->React.string} </p>
              </Tooltip.Content>
            </Tooltip>
          </Card.Action>
        </Card.Header>
        <Card.Content className="flex-1 overflow-hidden p-0">
          <MessageScroller key={demoKey->Int.toString}>
            <MessageScroller.Viewport>
              <MessageScroller.Content className="p-(--card-spacing)">
                <MessageScrollerExample.Transcript messages=visibleMessages anchorUsers=false />
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
            type_=Button
            disabled={!canLoadHistory}
            onClick={_ => {
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
