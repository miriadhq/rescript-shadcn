@@directive("'use client'")

let defaultPeek = 64.

let scriptedMessages: array<MessageScrollerExample.message> = [
  {
    id: "context-1",
    role: User,
    text: "I'm building a chat for our app and the scroll behavior is driving me nuts. Every time the AI streams a reply, the whole thread jumps around.",
  },
  {
    id: "context-2",
    role: Assistant,
    text: "That's the classic streaming scroll problem. Wrap your message list in `MessageScroller` and turn on `autoScroll` — the viewport pins to the bottom as tokens arrive, so users always see the latest text land in place.\n\nThe important part: it only auto-scrolls while the reader is already at the bottom. The moment they scroll up to read something earlier, auto-scroll backs off and their position is preserved. You get smooth streaming without fighting the user's intent.",
  },
  {
    id: "context-3",
    role: User,
    text: "Okay, but when someone sends a new message the view still feels jarring — like the whole conversation reloads from the top.",
  },
  {
    id: "context-4",
    role: Assistant,
    text: "MessageScrollerItem fixes that with turn anchoring. Set `scrollAnchor` on the turn that should settle near the top instead of blindly snapping to the document bottom.\n\nIt also leaves a small peek of the previous exchange visible above the anchor, so context isn't lost. The reply starts in view without that disorienting jump you get from a plain overflow container.",
  },
  {
    id: "context-5",
    role: User,
    text: "And if they've scrolled up to re-read an older answer? I don't want to yank them back down.",
  },
  {
    id: "context-6",
    role: Assistant,
    text: "You won't. Auto-scroll only runs when the viewport is already pinned to the bottom, so scrolling up is a deliberate opt-out — their place in the thread stays put even as new tokens keep arriving below.",
  },
]

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (demoKey, setDemoKey) = React.useState(() => 0)
  let (peek, setPeek) = React.useState(() => defaultPeek)
  let (visibleCount, setVisibleCount) = React.useState(() => 2)
  let messages = scriptedMessages->Array.slice(~start=0, ~end=visibleCount)
  let nextMessage = scriptedMessages->Array.get(visibleCount)

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
            <Tooltip.Trigger>
              <Button
                variant=Outline
                size=Icon
                ariaLabel="Reset context example"
                onPress={_ => {
                  setVisibleCount(_ => 2)
                  setPeek(_ => defaultPeek)
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
          <MessageScroller>
            <MessageScroller.Viewport>
              <MessageScroller.Content className="p-(--card-spacing)">
                <MessageScrollerExample.Transcript messages />
              </MessageScroller.Content>
            </MessageScroller.Viewport>
            <MessageScroller.Button />
          </MessageScroller>
        </Card.Content>
        <Card.Footer className="flex-col gap-2">
          <form
            onSubmit={event => {
              event->ReactEvent.Form.preventDefault
              nextMessage->Option.forEach(_ => setVisibleCount(count => count + 1))
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
                      {"No messages queued. Reset the context."->React.string}
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
                <div className="flex w-28 items-center gap-2">
                  <span className="text-xs text-muted-foreground tabular-nums">
                    {`${peek->Float.toInt->Int.toString}px`->React.string}
                  </span>
                  <Slider
                    ariaLabel="Previous context peek"
                    value={[peek]}
                    minValue=64.
                    maxValue=128.
                    step=1.
                    onChange={values =>
                      values->Array.get(0)->Option.forEach(value => setPeek(_ => value))}
                  />
                </div>
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
        {"Adjust the slider and send. Observe the previous message peak"->React.string}
      </div>
    </div>
  </MessageScroller.Provider>
}
