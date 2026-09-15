@@directive("'use client'")
@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

let chat = AiChat.createAiSdk()->AiChat.streamingScript
let initialMessages = chat->AiChat.get(0)
let transport = chat->AiChat.transport({delayMs: 20})

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let {messages, sendMessage, setMessages, status} = AiChat.useAiSdk({
    messages: initialMessages,
    transport,
  })
  let nextMessage = chat->AiChat.next(messages)->Nullable.toOption
  let isBusy = status == #submitted || status == #streaming

  <MessageScroller.Provider>
    <div className="relative flex flex-col gap-4">
      <Card className="mx-auto h-140 w-full max-w-sm gap-0">
        <Card.Header className="gap-1 border-b">
          <Card.Title> {"New Chat"->React.string} </Card.Title>
          <Card.Description>
            {"How can I help you today?"->React.string}
          </Card.Description>
          <Card.Action>
            <Tooltip>
              <Tooltip.Trigger
                render={<Button
                  variant=Outline
                  size=Icon
                  ariaLabel="Reset conversation"
                  disabled=isBusy
                  onClick={_ => setMessages(initialMessages)}
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
          {if messages->Array.length == 0 {
            <Empty className="h-full">
              <Empty.Header>
                <Empty.Media variant=Icon>
                  <Icons.MessageCircleDashed />
                </Empty.Media>
                <Empty.Title> {"Morning, shadcn!"->React.string} </Empty.Title>
                <Empty.Description>
                  {"What are we working on today? Press send to start a new conversation"->React.string}
                </Empty.Description>
              </Empty.Header>
            </Empty>
          } else {
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
          }}
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
                      {"No messages queued. Reset the conversation."->React.string}
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
        {"Demo is read only. Press send to send messages."->React.string}
      </div>
    </div>
  </MessageScroller.Provider>
}
