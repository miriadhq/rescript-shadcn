@@directive("'use client'")

@unboxed
module AnchorRole = {
  type t =
    | @as("user") UserAnchor
    | @as("assistant") AssistantAnchor
}

let scriptedMessages: array<MessageScrollerExample.MessageData.t> = [
  {
    id: "anchor-1-user",
    role: MessageScrollerExample.Role.User,
    text: "Can you show me how anchoring behaves when a new prompt starts the turn?",
  },
  {
    id: "anchor-1-assistant",
    role: MessageScrollerExample.Role.Assistant,
    text: "Append the user prompt first, then append the assistant response. With User selected, the prompt settles near the top and the assistant response fills in below it.",
  },
  {
    id: "anchor-2-user",
    role: MessageScrollerExample.Role.User,
    text: "What changes when assistant messages are the anchor?",
  },
  {
    id: "anchor-2-assistant",
    role: MessageScrollerExample.Role.Assistant,
    text: "Now each assistant response is the item `MessageScroller` keeps in view. This is useful when the reply is the moment you want readers to land on after each turn.",
  },
  {
    id: "anchor-3-user",
    role: MessageScrollerExample.Role.User,
    text: "Can I switch roles and keep adding turns?",
  },
  {
    id: "anchor-3-assistant",
    role: MessageScrollerExample.Role.Assistant,
    text: "Yes. The next appended message with the selected role becomes the anchor, so you can compare user and assistant anchoring without resetting the demo.",
  },
]

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (anchorRole, setAnchorRole) = React.useState(() => AnchorRole.UserAnchor)
  let (messageIndex, setMessageIndex) = React.useState(() => 0)
  let messages = scriptedMessages->Array.slice(~start=0, ~end=messageIndex)
  let nextMessage = scriptedMessages->Array.get(messageIndex)

  <div className="relative flex flex-col gap-4">
    <Card className="mx-auto h-140 w-full max-w-sm gap-0">
      <Card.Header className="border-b">
        <Card.Title> {"Anchoring Turns"->React.string} </Card.Title>
        <Card.Description>
          {"Choose which role settles near the top edge."->React.string}
        </Card.Description>
        <Card.Action>
          <Button
            type_="button"
            variant=Outline
            size=Icon
            ariaLabel="Reset anchored turns"
            isDisabled={messageIndex == 0}
            onPress={_ => setMessageIndex(_ => 0)}
          >
            <Icons.RotateCw />
          </Button>
        </Card.Action>
      </Card.Header>
      <Card.Content className="min-h-0 flex-1 overflow-hidden p-0">
        {if messages->Array.length == 0 {
          <Empty className="h-full">
            <Empty.Header>
              <Empty.Media variant=Icon>
                <Icons.MessageCircleDashed />
              </Empty.Media>
              <Empty.Title> {"No anchored messages yet"->React.string} </Empty.Title>
              <Empty.Description>
                {"Send the first message to see the selected role anchor."->React.string}
              </Empty.Description>
            </Empty.Header>
          </Empty>
        } else {
          <MessageScroller.Provider>
            <MessageScroller>
              <MessageScroller.Viewport>
                <MessageScroller.Content className="p-(--card-spacing)">
                  {messages
                  ->Array.map(message =>
                    <MessageScrollerExample.Item
                      key={message.id}
                      message
                      scrollAnchor={switch anchorRole {
                      | AnchorRole.UserAnchor => message.role == MessageScrollerExample.Role.User
                      | AnchorRole.AssistantAnchor =>
                        message.role == MessageScrollerExample.Role.Assistant
                      }}
                    />
                  )
                  ->React.array}
                </MessageScroller.Content>
              </MessageScroller.Viewport>
              <MessageScroller.Button />
            </MessageScroller>
          </MessageScroller.Provider>
        }}
      </Card.Content>
      <Card.Footer>
        <ToggleGroup
          ariaLabel="Select scroll anchor role"
          selectionMode=ReactAria.Common.SelectionMode.Single
          selectedKeys={[(anchorRole :> string)]}
          onSelectionChange={keys =>
            switch keys->Set.toArray->Array.get(0) {
            | Some("assistant") =>
              setAnchorRole(_ => AnchorRole.AssistantAnchor)
              setMessageIndex(_ => 0)
            | Some("user") =>
              setAnchorRole(_ => AnchorRole.UserAnchor)
              setMessageIndex(_ => 0)
            | _ => ()
            }}
        >
          <ToggleGroup.Item id="user" ariaLabel="Anchor user messages">
            {"User"->React.string}
          </ToggleGroup.Item>
          <ToggleGroup.Item id="assistant" ariaLabel="Anchor assistant messages">
            {"Assistant"->React.string}
          </ToggleGroup.Item>
        </ToggleGroup>
        <Button
          type_="button"
          size=Icon
          className="ml-auto"
          isDisabled={nextMessage->Option.isNone}
          onPress={_ => nextMessage->Option.forEach(_ => setMessageIndex(index => index + 1))}
        >
          <Icons.ArrowUp />
          <span className="sr-only"> {"Send Message"->React.string} </span>
        </Button>
      </Card.Footer>
    </Card>
    <div className="mx-auto max-w-xs px-0.5 text-center text-xs text-muted-foreground">
      {"Toggle the anchor role, then send messages to compare where turns settle."->React.string}
    </div>
  </div>
}
