@@directive("'use client'")

@unboxed
type turn =
  | @as("idle") Idle
  | @as("marker") Marker
  | @as("message") Message

type chatMessage = {
  id: string,
  sender: string,
  role: MessageScrollerExample.role,
  text: string,
  scrollAnchor: bool,
}

let currentUser = "Grace"

let initialMessages: array<chatMessage> = [
  {
    id: "group-1",
    sender: "Grace",
    role: User,
    text: "@mary, the astrophage line keeps matching Venus energy output. Can you check my math?",
    scrollAnchor: false,
  },
  {
    id: "group-2",
    sender: "Mary (Agent)",
    role: Assistant,
    text: "Yes. Confirmed. The curve points to a microorganism harvesting stellar energy and breeding near carbon dioxide. If @rocky agrees, this is the clue we need.",
    scrollAnchor: false,
  },
  {
    id: "group-3",
    sender: "Grace",
    role: User,
    text: "ping @rocky",
    scrollAnchor: true,
  },
]

let rockyMessage: chatMessage = {
  id: "group-5",
  sender: "Rocky",
  role: User,
  text: "Amaze. Astrophage eats light, makes heat, goes to carbon dioxide. Rocky has fuel model. Grace is smart.",
  scrollAnchor: false,
}

module ChatMessage = {
  @react.component
  let make = (~item: chatMessage) => {
    let isCurrentUser = item.sender == currentUser
    let variant = isCurrentUser ? Bubble.Variant.Muted : item.role == Assistant ? Ghost : Tinted
    <MessageScroller.Item messageId={item.id} scrollAnchor={item.scrollAnchor}>
      <Message align={isCurrentUser ? Message.Align.End : Start}>
        <Message.Content>
          {isCurrentUser
            ? React.null
            : <Message.Header> {item.sender->React.string} </Message.Header>}
          <Bubble variant>
            <Bubble.Content> {item.text->React.string} </Bubble.Content>
          </Bubble>
        </Message.Content>
      </Message>
    </MessageScroller.Item>
  }
}

module JoinMarker = {
  @react.component
  let make = () =>
    <MessageScroller.Item scrollAnchor=true>
      <Marker variant=Separator>
        <Marker.Content> {"Rocky has joined the chat"->React.string} </Marker.Content>
      </Marker>
    </MessageScroller.Item>
}

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (demoKey, setDemoKey) = React.useState(() => 0)
  let (rockyTurn, setRockyTurn) = React.useState(() => Idle)
  let buttonLabel = rockyTurn == Idle ? "Add Rocky" : "Send Message as Rocky"
  let isComplete = rockyTurn == Message

  <MessageScroller.Provider>
    <div className="relative flex flex-col gap-4">
      <Card className="mx-auto h-140 w-full max-w-sm gap-0">
        <Card.Header className="gap-1 border-b">
          <Card.Title> {"Group Chat"->React.string} </Card.Title>
          <Card.Description>
            {"A group chat with several participants and an assistant. The Marker is marked as a turn."->React.string}
          </Card.Description>
          <Card.Action>
            <Tooltip.Trigger>
              <Button
                type_="button"
                variant=Outline
                size=Icon
                ariaLabel="Reset conversation"
                isDisabled={rockyTurn == Idle}
                onPress={_ => {
                  setRockyTurn(_ => Idle)
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
        <Card.Content className="min-h-0 flex-1 p-0">
          <MessageScroller.Provider>
            <MessageScroller key={demoKey->Int.toString}>
              <MessageScroller.Viewport>
                <MessageScroller.Content className="p-(--card-spacing)">
                  {initialMessages
                  ->Array.map(item => <ChatMessage key={item.id} item />)
                  ->React.array}
                  {rockyTurn == Idle ? React.null : <JoinMarker />}
                  {rockyTurn == Message ? <ChatMessage item=rockyMessage /> : React.null}
                </MessageScroller.Content>
              </MessageScroller.Viewport>
              <MessageScroller.Button />
            </MessageScroller>
          </MessageScroller.Provider>
        </Card.Content>
        <Card.Footer className="flex flex-col items-center gap-2 border-t">
          <Button
            type_="button"
            isDisabled=isComplete
            onPress={_ => setRockyTurn(turn => turn == Idle ? Marker : Message)}
            className="w-full"
            variant=Secondary
          >
            {buttonLabel->React.string}
          </Button>
          <p className="text-xs text-muted-foreground">
            {(
              rockyTurn == Idle
                ? "This will create a marker and make it the anchor"
                : "Now send Rocky's reply into the conversation"
            )->React.string}
          </p>
        </Card.Footer>
      </Card>
      <div
        className="mx-auto max-w-sm px-0.5 text-center text-xs text-balance text-muted-foreground"
      >
        {"When a user joins, a marker is created. scrollAnchor on the marker marks it as the next turn"->React.string}
      </div>
    </div>
  </MessageScroller.Provider>
}
