@@directive("'use client'")

// The adapters use different text fields; these demos render text and reasoning parts.
type part = {@as("type") type_: string, text?: string, content?: string}
type message = {id: string, role: MessageScrollerExample.role, parts: array<part>}
type chat<'transport>
type aiSdkTransport
type tanstackConnection
type writer
type writerContext = {writer: writer}
type transportOptions = {delayMs: int}

@module("@shadcn/helpers/ai-sdk") external createAiSdk: unit => chat<aiSdkTransport> = "createChat"
@module("@shadcn/helpers/tanstack-ai")
external createTanstack: unit => chat<tanstackConnection> = "createChat"
@send external user: (chat<'t>, string) => chat<'t> = "user"
@send external assistant: (chat<'t>, string) => chat<'t> = "assistant"
@send external assistantWith: (chat<'t>, writerContext => unit) => chat<'t> = "assistant"
@send external sleep: (chat<'t>, int) => chat<'t> = "sleep"
@send external text: (writer, string) => writer = "text"
@send external reasoning: (writer, string) => writer = "reasoning"
@send external writerSleep: (writer, int) => writer = "sleep"
@send external get: (chat<'t>, int) => array<message> = "get"
@send external next: (chat<'t>, array<message>) => nullable<message> = "next"
@send external transport: (chat<'t>, transportOptions) => 't = "transport"

type status = [#submitted | #streaming | #ready | #error]
type aiSdkOptions = {messages: array<message>, transport: aiSdkTransport}
type aiSdkState = {
  messages: array<message>,
  status: status,
  sendMessage: message => promise<unit>,
  setMessages: array<message> => unit,
}
@module("@ai-sdk/react") external useAiSdk: aiSdkOptions => aiSdkState = "useChat"
type tanstackOptions = {initialMessages: array<message>, connection: tanstackConnection}
type tanstackState = {
  messages: array<message>,
  status: status,
  append: message => promise<unit>,
  setMessages: array<message> => unit,
}
@module("@tanstack/ai-react") external useTanstack: tanstackOptions => tanstackState = "useChat"

let partText = part => part.text->Option.orElse(part.content)->Option.getOr("")
let messageText = message =>
  message.parts->Array.filter(p => p.type_ == "text")->Array.map(partText)->Array.join("")

let script = chat =>
  chat
  ->user(
    "I'm building a chat for our app and the scroll behavior is driving me nuts. Every time the AI streams a reply, the whole thread jumps around.",
  )
  ->sleep(1000)
  ->assistantWith(({writer}) => {
    writer
    ->reasoning(
      "They are describing a streaming transcript that keeps taking control of the viewport. I should explain when auto-scroll follows and when it stops.",
    )
    ->ignore
    writer->writerSleep(1000)->ignore
    writer
    ->text(
      "That's the classic streaming scroll problem. Wrap your message list in `MessageScroller` and turn on `autoScroll` — the viewport pins to the bottom as tokens arrive, so users always see the latest text land in place.\n\nThe important part: it only auto-scrolls while the reader is already at the bottom. The moment they scroll up to read something earlier, auto-scroll backs off and their position is preserved. You get smooth streaming without fighting the user's intent.",
    )
    ->ignore
  })
  ->user(
    "Okay, but when someone sends a new message the view still feels jarring — like the whole conversation reloads from the top.",
  )
  ->sleep(1000)
  ->assistant(
    "MessageScrollerItem fixes that with turn anchoring. Set `scrollAnchor` on the turn that should settle near the top instead of blindly snapping to the document bottom.\n\nIt also leaves a small peek of the previous exchange visible above the anchor, so context isn't lost. The reply starts in view without that disorienting jump you get from a plain overflow container.",
  )
  ->user(
    "And if they've scrolled up to re-read an older answer? I don't want to yank them back down.",
  )
  ->sleep(1000)
  ->assistant(
    "You won't. Auto-scroll only runs when the viewport is already pinned to the bottom, so scrolling up is a deliberate opt-out — their place in the thread stays put even as new tokens keep arriving below.\n\nWhen there is content they haven't seen yet, `MessageScrollerButton` appears at the bottom of the viewport. One tap jumps them back to the newest message and re-engages auto-scroll. Same pattern as Slack or iMessage: quiet when you're caught up, helpful when you're not.",
  )
  ->user("Last one — does this work with assistive tech?")
  ->sleep(1000)
  ->assistant(
    "`MessageScrollerContent` sets `role=\"log\"` and `aria-relevant=\"additions\"` by default, so screen readers announce new messages as they stream in.\n\nThe scroll button is a real `<button>` with an sr-only label, and it's removed from the tab order when you're already at the bottom — no ghost focus stops.",
  )

let streamingScript = chat =>
  chat
  ->user(
    "I'm building a chat for our app and the scroll behavior is driving me nuts. Every time the AI streams a reply, the whole thread jumps around.",
  )
  ->sleep(1000)
  ->assistant(
    "That's the classic streaming scroll problem. Wrap your message list in `MessageScroller` and turn on `autoScroll` — the viewport pins to the bottom as tokens arrive, so users always see the latest text land in place.\n\nThe important part: it only auto-scrolls while the reader is already at the bottom. The moment they scroll up to read something earlier, auto-scroll backs off and their position is preserved. You get smooth streaming without fighting the user's intent.",
  )
  ->user(
    "Okay, but when someone sends a new message the view still feels jarring — like the whole conversation reloads from the top.",
  )
  ->sleep(1000)
  ->assistant(
    "MessageScrollerItem fixes that with turn anchoring. Set `scrollAnchor` on the turn that should settle near the top instead of blindly snapping to the document bottom.\n\nIt also leaves a small peek of the previous exchange visible above the anchor, so context isn't lost. The reply starts in view without that disorienting jump you get from a plain overflow container.",
  )
  ->user(
    "And if they've scrolled up to re-read an older answer? I don't want to yank them back down.",
  )
  ->sleep(1000)
  ->assistant(
    "You won't. Auto-scroll only runs when the viewport is already pinned to the bottom, so scrolling up is a deliberate opt-out — their place in the thread stays put even as new tokens keep arriving below.\n\nWhen there is content they haven't seen yet, `MessageScrollerButton` appears at the bottom of the viewport. One tap jumps them back to the newest message and re-engages auto-scroll. Same pattern as Slack or iMessage: quiet when you're caught up, helpful when you're not.",
  )
  ->user("Last one — does this work with assistive tech?")
  ->sleep(1000)
  ->assistant(
    "`MessageScrollerContent` sets `role=\"log\"` and `aria-relevant=\"additions\"` by default, so screen readers announce new messages as they stream in.\n\nThe scroll button is a real `<button>` with an sr-only label, and it's removed from the tab order when you're already at the bottom — no ghost focus stops.",
  )

let animationScript = chat =>
  chat
  ->user("Can user messages pop in like iMessage without breaking anchoring?")
  ->sleep(1000)
  ->assistant(
    "Yes. Animate the user row with transform and opacity, and let the assistant response stream normally below it.\n\nThat keeps the row measurement predictable while still giving the newly sent bubble a more tactile entrance.",
  )
  ->user("What makes the animation feel more like iMessage?")
  ->sleep(1000)
  ->assistant(
    "Use a quick spring from the trailing edge: a little scale, a small upward move, and no layout animation.\n\nThe bubble feels tactile, but the measured row stays predictable, so anchoring and auto-scroll do not have to fight a changing layout.",
  )
  ->user("Can I switch between presets while testing the same thread?")
  ->sleep(1000)
  ->assistant(
    "Yes. Keep the conversation in place while you change the preset, then send the next message to compare the new entrance against the same context.\n\nThat makes it easier to judge the difference between a subtle fade, a snappy pop, and a more dramatic 3D tilt without rebuilding the scenario each time.",
  )
