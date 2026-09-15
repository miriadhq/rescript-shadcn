@@directive("'use client'")

let chat = AiChat.createAiSdk()->AiChat.animationScript
let initialMessages = chat->AiChat.get(0)
let transport = chat->AiChat.transport({delayMs: 15})
let presets = MessageAnimated.presets

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let {messages, sendMessage, setMessages, status} = AiChat.useAiSdk({
    messages: initialMessages,
    transport,
  })
  let (presetId, setPresetId) = React.useState(() => "fade")
  let nextMessage = chat->AiChat.next(messages)->Nullable.toOption
  let isBusy = status == #submitted || status == #streaming
  let preset = MessageAnimated.preset(presetId)

  <div className="relative flex flex-col gap-4">
    <Card className="mx-auto h-140 w-full max-w-sm gap-0">
      <Card.Header className="border-b">
        <Card.Title> {"Animation"->React.string} </Card.Title>
        <Card.Description>
          {"Choose how user messages are animated when they are added to the conversation."->React.string}
        </Card.Description>
        <Card.Action className="flex items-center gap-2">
          <Button
            type_=Button
            variant=Outline
            size=Icon
            ariaLabel="Reset animated messages"
            disabled={messages->Array.length == 0 || isBusy}
            onClick={_ => setMessages(initialMessages)}
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
                <MessageScroller.Content ariaBusy=isBusy className="p-(--card-spacing)">
                  {messages
                  ->Array.map(message =>
                    <MessageAnimated key={message.id} message animationPreset=preset />
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
        <Select
          value={presetId->Nullable.make}
          onValueChange={(value, _) =>
            value->Nullable.toOption->Option.forEach(value => setPresetId(_ => value))}
        >
          <Select.Trigger ariaLabel="Animation preset">
            <Select.Value> {preset.name->React.string} </Select.Value>
          </Select.Trigger>
          <Select.Content side=Top align=Start>
            <Select.Group>
              {presets
              ->Array.map(item =>
                <Select.Item key={item.id} value={item.id}> {item.name->React.string} </Select.Item>
              )
              ->React.array}
            </Select.Group>
          </Select.Content>
        </Select>
        <Button
          type_=Button
          size=Icon
          className="ml-auto"
          disabled={nextMessage->Option.isNone || isBusy}
          onClick={_ =>
            if !isBusy {
              nextMessage->Option.forEach(message => sendMessage(message)->ignore)
            }}
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
