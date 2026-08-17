@@directive("'use client'")

module Preset = {
  type t = {id: string, name: string, className: string}
}

let presets: array<Preset.t> = [
  {id: "fade", name: "Fade", className: "animate-in fade-in duration-200"},
  {
    id: "slide-up",
    name: "Slide Up",
    className: "animate-in fade-in slide-in-from-bottom-2 duration-200",
  },
  {
    id: "slide-side",
    name: "Slide Side",
    className: "animate-in fade-in slide-in-from-right-4 duration-200",
  },
  {id: "pop", name: "Pop", className: "animate-in fade-in zoom-in-95 duration-200"},
  {
    id: "spring-bounce",
    name: "Spring Bounce",
    className: "animate-in fade-in zoom-in-95 slide-in-from-bottom-2 duration-300",
  },
  {id: "blur-fade", name: "Blur Fade", className: "animate-in fade-in duration-300"},
  {id: "scale-fade", name: "Scale Fade", className: "animate-in fade-in zoom-in-95 duration-200"},
]

let messages: array<MessageScrollerExample.MessageData.t> = [
  {
    id: "animation-1",
    role: MessageScrollerExample.Role.User,
    text: "Can user messages pop in like iMessage without breaking anchoring?",
  },
  {
    id: "animation-2",
    role: MessageScrollerExample.Role.Assistant,
    text: "Yes. Animate the user row with transform and opacity, and let the assistant response stream normally below it.\n\nThat keeps the row measurement predictable while still giving the newly sent bubble a more tactile entrance.",
  },
  {
    id: "animation-3",
    role: MessageScrollerExample.Role.User,
    text: "What makes the animation feel more like iMessage?",
  },
  {
    id: "animation-4",
    role: MessageScrollerExample.Role.Assistant,
    text: "Use a quick spring from the trailing edge: a little scale, a small upward move, and no layout animation.\n\nThe bubble feels tactile, but the measured row stays predictable, so anchoring and auto-scroll do not have to fight a changing layout.",
  },
  {
    id: "animation-5",
    role: MessageScrollerExample.Role.User,
    text: "Can I switch between presets while testing the same thread?",
  },
  {
    id: "animation-6",
    role: MessageScrollerExample.Role.Assistant,
    text: "Yes. Keep the conversation in place while you change the preset, then send the next message to compare the new entrance against the same context.",
  },
]

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (messageCount, setMessageCount) = React.useState(() => 0)
  let (presetId, setPresetId) = React.useState(() => "fade")
  let visibleMessages = messages->Array.slice(~start=0, ~end=messageCount)
  let preset =
    presets
    ->Array.find(item => item.id == presetId)
    ->Option.getOr({id: "fade", name: "Fade", className: "animate-in fade-in duration-200"})
  let nextMessage = messages->Array.get(messageCount)

  <div className="relative flex flex-col gap-4">
    <Card className="mx-auto h-140 w-full max-w-sm gap-0">
      <Card.Header className="border-b">
        <Card.Title> {"Animation"->React.string} </Card.Title>
        <Card.Description>
          {"Choose how user messages are animated when they are added to the conversation."->React.string}
        </Card.Description>
        <Card.Action className="flex items-center gap-2">
          <Button
            type_="button"
            variant=Outline
            size=Icon
            ariaLabel="Reset animated messages"
            isDisabled={messageCount == 0}
            onPress={_ => setMessageCount(_ => 0)}
          >
            <Icons.RotateCw />
          </Button>
        </Card.Action>
      </Card.Header>
      <Card.Content className="min-h-0 flex-1 overflow-hidden p-0">
        {if messageCount == 0 {
          <Empty className="h-full">
            <Empty.Header>
              <Empty.Media variant=Icon>
                <Icons.MessageCircleDashed />
              </Empty.Media>
              <Empty.Title> {"No Messages Yet"->React.string} </Empty.Title>
              <Empty.Description>
                {"Click the button below to send the first message."->React.string}
              </Empty.Description>
            </Empty.Header>
          </Empty>
        } else {
          <MessageScroller.Provider>
            <MessageScroller>
              <MessageScroller.Viewport>
                <MessageScroller.Content className="p-(--card-spacing)">
                  {visibleMessages
                  ->Array.mapWithIndex((message, index) =>
                    <div
                      key={message.id}
                      className={index == messageCount - 1 &&
                        message.role == MessageScrollerExample.Role.User
                        ? preset.className
                        : ""}
                    >
                      <MessageScrollerExample.Item message />
                    </div>
                  )
                  ->React.array}
                </MessageScroller.Content>
              </MessageScroller.Viewport>
              <MessageScroller.Button />
            </MessageScroller>
          </MessageScroller.Provider>
        }}
      </Card.Content>
      <Card.Footer className="border-t">
        <Select value=presetId onChange={value => setPresetId(_ => value)}>
          <Select.Trigger ariaLabel="Animation preset">
            <Select.Value> {preset.name->React.string} </Select.Value>
          </Select.Trigger>
          <Select.Content placement=ReactAria.Common.Placement.TopStart>
            <Select.Group>
              {presets
              ->Array.map(item =>
                <Select.Item key={item.id} id={item.id}> {item.name->React.string} </Select.Item>
              )
              ->React.array}
            </Select.Group>
          </Select.Content>
        </Select>
        <Button
          type_="button"
          size=Icon
          className="ml-auto"
          isDisabled={nextMessage->Option.isNone}
          onPress={_ => nextMessage->Option.forEach(_ => setMessageCount(count => count + 1))}
        >
          <Icons.ArrowUp />
          <span className="sr-only"> {"Send Message"->React.string} </span>
        </Button>
      </Card.Footer>
    </Card>
    <div className="mx-auto max-w-sm px-0.5 text-center text-xs text-balance text-muted-foreground">
      {"Select an animation then click send to see it in action."->React.string}
    </div>
  </div>
}
