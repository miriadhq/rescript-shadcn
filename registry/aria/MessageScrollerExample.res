module Role = {
  @unboxed
  type t =
    | @as("user") User
    | @as("assistant") Assistant
}

module MessageData = {
  type t = {id: string, role: Role.t, text: string}
}

let paragraphs = text =>
  text
  ->String.split("\n\n")
  ->Array.map(String.trim)
  ->Array.filter(paragraph => paragraph != "")
  ->Array.mapWithIndex((paragraph, index) =>
    <p key={index->Int.toString} className="whitespace-pre-wrap"> {paragraph->React.string} </p>
  )
  ->React.array

module Item = {
  @react.component
  let make = (
    ~message: MessageData.t,
    ~scrollAnchor=false,
    ~userVariant=Bubble.Variant.Muted,
    ~assistantVariant=Bubble.Variant.Ghost,
  ) => {
    let isUser = message.role == Role.User
    <MessageScroller.Item messageId={message.id} scrollAnchor>
      <Message align={isUser ? Message.Align.End : Message.Align.Start}>
        <Message.Content>
          <Bubble variant={isUser ? userVariant : assistantVariant}>
            <Bubble.Content className="space-y-2"> {message.text->paragraphs} </Bubble.Content>
          </Bubble>
        </Message.Content>
      </Message>
    </MessageScroller.Item>
  }
}

module Transcript = {
  @react.component
  let make = (
    ~messages: array<MessageData.t>,
    ~anchorUsers=true,
    ~userVariant=Bubble.Variant.Muted,
    ~assistantVariant=Bubble.Variant.Ghost,
  ) =>
    messages
    ->Array.map(message =>
      <Item
        key={message.id}
        message
        scrollAnchor={anchorUsers && message.role == Role.User}
        userVariant
        assistantVariant
      />
    )
    ->React.array
}
