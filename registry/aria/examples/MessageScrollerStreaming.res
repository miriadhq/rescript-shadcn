@@directive("'use client'")

let messages: array<MessageScrollerExample.message> = [
  {
    id: "stream-1",
    role: User,
    text: "I'm building a chat for our app and the scroll behavior is driving me nuts. Every time the AI streams a reply, the whole thread jumps around.",
  },
  {
    id: "stream-2",
    role: Assistant,
    text: "That's the classic streaming scroll problem. Wrap your message list in `MessageScroller` and turn on `autoScroll` — the viewport pins to the bottom as tokens arrive, so users always see the latest text land in place.\n\nThe important part: it only auto-scrolls while the reader is already at the bottom. The moment they scroll up to read something earlier, auto-scroll backs off and their position is preserved.",
  },
  {
    id: "stream-3",
    role: User,
    text: "Okay, but when someone sends a new message the view still feels jarring — like the whole conversation reloads from the top.",
  },
  {
    id: "stream-4",
    role: Assistant,
    text: "MessageScrollerItem fixes that with turn anchoring. Set `scrollAnchor` on the turn that should settle near the top instead of blindly snapping to the document bottom.",
  },
  {
    id: "stream-5",
    role: User,
    text: "And if they've scrolled up to re-read an older answer? I don't want to yank them back down.",
  },
  {
    id: "stream-6",
    role: Assistant,
    text: "You won't. Auto-scroll only runs when the viewport is already pinned to the bottom, so scrolling up is a deliberate opt-out — their place in the thread stays put even as new tokens keep arriving below.",
  },
  {id: "stream-7", role: User, text: "Last one — does this work with assistive tech?"},
  {
    id: "stream-8",
    role: Assistant,
    text: "`MessageScrollerContent` sets `role=\"log\"` and `aria-relevant=\"additions\"` by default, so screen readers announce new messages as they stream in.",
  },
]

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (messageCount, setMessageCount) = React.useState(() => 0)
  let visibleMessages = messages->Array.slice(~start=0, ~end=messageCount)
  let nextMessage = messages->Array.get(messageCount)

  <MessageScroller.Provider autoScroll=true>
    <div className="relative flex flex-col gap-4">
      <Card className="mx-auto h-140 w-full max-w-sm gap-0">
        <Card.Header className="gap-1 border-b">
          <Card.Title> {"Streaming Messages"->React.string} </Card.Title>
          <Card.Description>
            {"Auto-scroll follows the live edge of the conversation."->React.string}
          </Card.Description>
          <Card.Action>
            <Tooltip.Trigger>
              <Button
                variant=Outline
                size=Icon
                ariaLabel="Reset stream"
                isDisabled={messageCount == 0}
                onPress={_ => setMessageCount(_ => 0)}
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
          {if messageCount == 0 {
            <Empty className="h-full">
              <Empty.Header>
                <Empty.Media variant=Icon>
                  <Icons.MessageCircleDashed />
                </Empty.Media>
                <Empty.Title> {"Ready to Stream"->React.string} </Empty.Title>
                <Empty.Description>
                  {"Press send to stream a scripted launch summary."->React.string}
                </Empty.Description>
              </Empty.Header>
            </Empty>
          } else {
            <MessageScroller>
              <MessageScroller.Viewport>
                <MessageScroller.Content className="p-(--card-spacing)">
                  <MessageScrollerExample.Transcript messages=visibleMessages />
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
              nextMessage->Option.forEach(_ => setMessageCount(count => count + 1))
            }}
            className="w-full"
          >
            <InputGroup>
              <div className="h-14 w-full px-3 py-2.5">
                <span className="line-clamp-2 opacity-60">
                  {switch nextMessage {
                  | Some(message) => message.text->React.string
                  | None =>
                    <span className="text-muted-foreground">
                      {"No messages queued. Reset the stream."->React.string}
                    </span>
                  }}
                </span>
              </div>
              <InputGroup.Addon align=BlockEnd className="pt-1">
                <DropdownMenu.Trigger>
                  <InputGroup.Button
                    ariaLabel="Add files" type_="button" size=IconSm variant=Outline
                  >
                    <Icons.Plus />
                  </InputGroup.Button>
                  <DropdownMenu placement=ReactAria.Common.TopStart className="w-44">
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
                  </DropdownMenu>
                </DropdownMenu.Trigger>
                <InputGroup.Button
                  type_="submit"
                  variant=Default
                  size=IconSm
                  isDisabled={nextMessage->Option.isNone}
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
        {"Streaming is simulated. `autoScroll` is enabled."->React.string}
      </div>
    </div>
  </MessageScroller.Provider>
}
