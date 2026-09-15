@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})
@@directive("'use client'")

let defaultPeek = 64.

let chat = AiChat.createAiSdk()->AiChat.streamingScript
let initialMessages = chat->AiChat.get(2)
let transport = chat->AiChat.transport({delayMs: 35})

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (demoKey, setDemoKey) = React.useState(() => 0)
  let (peek, setPeek) = React.useState(() => defaultPeek)
  let {messages, sendMessage, setMessages, status} = AiChat.useAiSdk({
    messages: initialMessages,
    transport,
  })
  let nextMessage = chat->AiChat.next(messages)->Nullable.toOption
  let isBusy = status == #submitted || status == #streaming

  <MessageScroller.Provider
    key={demoKey->Int.toString} scrollMargin=24. scrollPreviousItemPeek=peek
  >
    <div className="relative flex flex-col gap-4">
      <Card className="mx-auto h-140 w-full max-w-sm gap-0">
        <Card.Header className="gap-1 border-b">
          <Card.Title> {"Keeping Context Visible"->React.string} </Card.Title>
          <Card.Description>
            {"New turns keep part of the previous reply in view."->React.string}
          </Card.Description>
          <Card.Action>
            <Tooltip>
              <Tooltip.Trigger
                render={<Button
                  variant=Outline
                  size=Icon
                  ariaLabel="Reset context example"
                  disabled=isBusy
                  onClick={_ => {
                    setMessages(initialMessages)
                    setPeek(_ => defaultPeek)
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
          <MessageScroller>
            <MessageScroller.Viewport>
              <MessageScroller.Content ariaBusy=isBusy className="p-(--card-spacing)">
                {messages
                ->Array.map(message =>
                  <MessageAnimated key={message.id} message scrollAnchor={message.role == User} />
                )
                ->React.array}
              </MessageScroller.Content>
            </MessageScroller.Viewport>
            <MessageScroller.Button />
          </MessageScroller>
        </Card.Content>
        <Card.Footer className="flex-col gap-2">
          <form
            onSubmit={event => {
              event->ReactEvent.Form.preventDefault
              if !isBusy {
                nextMessage->Option.forEach(message => sendMessage(message)->ignore)
              }
            }}
            className="w-full"
          >
            <InputGroup>
              <div className="h-14 w-full px-3 py-2.5">
                <span
                  className="line-clamp-2 opacity-60 data-[status=ready]:opacity-100"
                  dataStatus={(status :> string)}
                >
                  {switch nextMessage {
                  | Some(message) => message->AiChat.messageText->React.string
                  | None =>
                    <span className="text-muted-foreground">
                      {"No messages queued. Reset the context."->React.string}
                    </span>
                  }}
                </span>
              </div>
              <InputGroup.Addon align=BlockEnd className="pt-1">
                <DropdownMenu>
                  <DropdownMenu.Trigger
                    render={<InputGroup.Button
                      ariaLabel="Add files" type_=Button size=IconSm variant=Outline
                    />}
                  >
                    <Icons.Plus />
                  </DropdownMenu.Trigger>
                  <DropdownMenu.Content side=Top align=Start className="w-44">
                    <DropdownMenu.Item>
                      <Icons.Paperclip />
                      {"Add Photos & Files"->React.string}
                    </DropdownMenu.Item>
                    <DropdownMenu.Separator />
                    <DropdownMenu.Item>
                      <Icons.Image />
                      {"Create Image"->React.string}
                    </DropdownMenu.Item>
                    <DropdownMenu.Item>
                      <Icons.Telescope />
                      {"Deep Research"->React.string}
                    </DropdownMenu.Item>
                    <DropdownMenu.Item>
                      <Icons.Globe />
                      {"Web Search"->React.string}
                    </DropdownMenu.Item>
                  </DropdownMenu.Content>
                </DropdownMenu>
                <div className="flex w-28 items-center gap-2">
                  <span className="text-xs text-muted-foreground tabular-nums">
                    {React.int(peek->Float.toInt)}
                    {React.string("px")}
                  </span>
                  <Slider
                    ariaLabel="Previous context peek"
                    disabled=isBusy
                    value={[peek]}
                    min=64.
                    max=128.
                    step=1.
                    onValueChange={(values, _) =>
                      values->Array.get(0)->Option.forEach(value => setPeek(_ => value))}
                  />
                </div>
                <InputGroup.Button
                  type_=Submit
                  variant=Default
                  size=IconSm
                  disabled={nextMessage->Option.isNone || isBusy}
                  className="ml-auto"
                >
                  <Icons.ArrowUp />
                  <span className="sr-only"> {"Send"->React.string} </span>
                </InputGroup.Button>
              </InputGroup.Addon>
            </InputGroup>
          </form>
        </Card.Footer>
      </Card>
      <div className="px-0.5 text-center text-xs text-muted-foreground">
        {"Adjust the slider and send. Observe the previous message peak"->React.string}
      </div>
    </div>
  </MessageScroller.Provider>
}
