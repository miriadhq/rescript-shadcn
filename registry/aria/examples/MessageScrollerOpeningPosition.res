@@directive("'use client'")

type position = MessageScroller.DefaultScrollPosition.t

let messages: array<MessageScrollerExample.message> = [
  {id: "open-1", role: User, text: "This is the first message the user sent in the conversation."},
  {id: "open-2", role: Assistant, text: "Workspace creation rose 8%, but first invite completion only rose 2%."},
  {id: "open-3", role: User, text: "This is the last message the user sent in the conversation."},
  {id: "open-4", role: Assistant, text: "Start with the invite step. Teams are creating workspaces but waiting to add collaborators.\n\nRecommended follow-up:\n\n1. Compare invite drop-off by account size.\n2. Check whether users who skip invites still return within 24 hours.\n3. Review the empty-state copy on the first project screen.\n4. Segment activation by template, since template users may not need invites right away.\n\nIf that pattern holds, the next experiment should make collaboration useful earlier instead of prompting for invites harder."},
]

module Scroller = {
  @react.component
  let make = (~position: position, ~positionKey: int) => {
    let {scrollToEnd, scrollToMessage, scrollToStart} = MessageScroller.useMessageScroller()
    React.useEffect(() => {
      switch position {
      | Start => scrollToStart(Some({behavior: Auto}))->ignore
      | End => scrollToEnd(Some({behavior: Auto}))->ignore
      | LastAnchor =>
        scrollToMessage(
          "open-3",
          Some({align: Start, behavior: Auto, scrollMargin: 64.}),
        )->ignore
      }
      None
    }, [positionKey])
    <MessageScroller>
      <MessageScroller.Viewport>
        <MessageScroller.Content className="p-(--card-spacing)">
          <MessageScrollerExample.Transcript messages />
        </MessageScroller.Content>
      </MessageScroller.Viewport>
      <MessageScroller.Button />
    </MessageScroller>
  }
}

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (positionKey, setPositionKey) = React.useState(() => 0)
  let (position, setPosition) = React.useState(() => MessageScroller.DefaultScrollPosition.LastAnchor)
  <div className="relative flex flex-col gap-4">
    <Card className="mx-auto h-140 w-full max-w-sm gap-0">
      <Card.Header className="gap-1 border-b">
        <Card.Title> {"Opening Position"->React.string} </Card.Title>
        <Card.Description> {"Choose where a saved transcript opens."->React.string} </Card.Description>
      </Card.Header>
      <Card.Content className="flex-1 overflow-hidden p-0">
        <MessageScroller.Provider>
          <Scroller position positionKey />
        </MessageScroller.Provider>
      </Card.Content>
      <Card.Footer className="flex items-center justify-center border-t">
        <Tabs
          selectedKey={(position :> string)}
          onSelectionChange={value => {
            let next = switch value {
            | "start" => Some(MessageScroller.DefaultScrollPosition.Start)
            | "end" => Some(MessageScroller.DefaultScrollPosition.End)
            | "last-anchor" => Some(MessageScroller.DefaultScrollPosition.LastAnchor)
            | _ => None
            }
            next->Option.forEach(position => {
              setPosition(_ => position)
              setPositionKey(key => key + 1)
            })
          }}
          className="w-full"
        >
          <Tabs.List className="w-full">
            <Tabs.Trigger id="start"> {"start"->React.string} </Tabs.Trigger>
            <Tabs.Trigger id="end"> {"end"->React.string} </Tabs.Trigger>
            <Tabs.Trigger id="last-anchor"> {"last-anchor"->React.string} </Tabs.Trigger>
          </Tabs.List>
        </Tabs>
      </Card.Footer>
    </Card>
    <div className="mx-auto max-w-sm px-0.5 text-center text-xs text-muted-foreground">
      {"Toggle the defaultScrollPosition to see where the transcript starts when you open the thread"->React.string}
    </div>
  </div>
}
