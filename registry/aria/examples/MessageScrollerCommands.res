@@directive("'use client'")

let messages: array<MessageScrollerExample.MessageData.t> = [
  {
    id: "command-activation",
    role: MessageScrollerExample.Role.User,
    text: "We're seeing activation dip after workspace creation. Can you help me find the likely step?",
  },
  {
    id: "command-activation-answer",
    role: MessageScrollerExample.Role.Assistant,
    text: "The sharpest drop is between creating the workspace and inviting the first teammate.\n\nWorkspace creation is still healthy, but the invite step is where users pause. That suggests the product is asking for collaboration before the user has enough confidence in the workspace.",
  },
  {
    id: "command-compare",
    role: MessageScrollerExample.Role.User,
    text: "What should I compare before we change the onboarding flow?",
  },
  {
    id: "command-compare-answer",
    role: MessageScrollerExample.Role.Assistant,
    text: "Compare three cohorts:\n\n1. Users who choose a template before inviting teammates.\n2. Users who start from a blank workspace.\n3. Users who skip invites and return within 24 hours.\n\nIf template users invite faster, the fix is probably better first-run guidance rather than a louder invite prompt.",
  },
  {
    id: "command-experiment",
    role: MessageScrollerExample.Role.User,
    text: "Can you turn that into an experiment?",
  },
  {
    id: "command-experiment-answer",
    role: MessageScrollerExample.Role.Assistant,
    text: "Yes. Create a variant that shows a short checklist after workspace creation:\n\n- Pick a template.\n- Add one project detail.\n- Invite a teammate when the workspace has context.\n\nMeasure first invite completion, 24-hour return rate, and whether teams create a second project.",
  },
  {
    id: "command-risk",
    role: MessageScrollerExample.Role.User,
    text: "What's the risk if we delay the invite prompt?",
  },
  {
    id: "command-risk-answer",
    role: MessageScrollerExample.Role.Assistant,
    text: "The main risk is reducing team creation for accounts that already know who they want to invite.\n\nTo protect that path, keep the invite action visible in the header and only change the primary empty-state guidance. That gives confident teams a direct route without forcing uncertain users through the invite step too early.",
  },
]

let userMessages =
  messages->Array.filter(message => message.role == MessageScrollerExample.Role.User)

let trimmed = text =>
  text->String.length > 42 ? `${text->String.slice(~start=0, ~end=39)}...` : text

module CommandMenu = {
  @react.component
  let make = () => {
    let {scrollToMessage} = MessageScroller.useMessageScroller()
    <DropdownMenu.Trigger>
      <Button type_="button" variant=Secondary> {"Jump to..."->React.string} </Button>
      <DropdownMenu placement=ReactAria.Common.Placement.BottomEnd className="w-64">
        <DropdownMenu.Label> {"Conversations"->React.string} </DropdownMenu.Label>
        {userMessages
        ->Array.map(message =>
          <DropdownMenu.Item
            key={message.id}
            onAction={() =>
              scrollToMessage(message.id, Some({align: Start, behavior: Smooth}))->ignore}
          >
            <span className="line-clamp-1 min-w-0"> {message.text->trimmed->React.string} </span>
          </DropdownMenu.Item>
        )
        ->React.array}
      </DropdownMenu>
    </DropdownMenu.Trigger>
  }
}

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <MessageScroller.Provider defaultScrollPosition=End>
    <div className="relative flex flex-col gap-4">
      <Card className="mx-auto h-140 w-full max-w-sm gap-0">
        <Card.Header className="gap-1 border-b">
          <Card.Title> {"Commands"->React.string} </Card.Title>
          <Card.Description>
            {"Drive the transcript from outside."->React.string}
          </Card.Description>
          <Card.Action>
            <CommandMenu />
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
      </Card>
      <div
        className="mx-auto max-w-sm px-0.5 text-center text-xs text-balance text-muted-foreground"
      >
        {"Use the controls to jump to any message in the conversation."->React.string}
      </div>
    </div>
  </MessageScroller.Provider>
