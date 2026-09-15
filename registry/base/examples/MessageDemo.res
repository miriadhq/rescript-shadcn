@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex w-full max-w-sm flex-col gap-6 py-12">
    <Message align=End>
      <Message.Avatar>
        <Avatar>
          <Avatar.Image src="/avatars/10.png" alt="@me" />
          <Avatar.Fallback> {"ME"->React.string} </Avatar.Fallback>
        </Avatar>
      </Message.Avatar>
      <Message.Content>
        <Bubble>
          <Bubble.Content> {"Deploying to prod real quick."->React.string} </Bubble.Content>
        </Bubble>
      </Message.Content>
    </Message>
    <Message>
      <Message.Avatar>
        <Avatar>
          <Avatar.Image src="/avatars/02.png" alt="@rabbit" />
          <Avatar.Fallback> {"R"->React.string} </Avatar.Fallback>
        </Avatar>
      </Message.Avatar>
      <Message.Content>
        <Bubble variant=Muted>
          <Bubble.Content> {"It's 4:55 PM. On a Friday."->React.string} </Bubble.Content>
        </Bubble>
      </Message.Content>
    </Message>
    <Message align=End>
      <Message.Avatar>
        <Avatar>
          <Avatar.Image src="/avatars/10.png" alt="@me" />
          <Avatar.Fallback> {"ME"->React.string} </Avatar.Fallback>
        </Avatar>
      </Message.Avatar>
      <Message.Content>
        <Bubble>
          <Bubble.Content> {"It's a one-line change."->React.string} </Bubble.Content>
        </Bubble>
        <Message.Footer> {"Delivered"->React.string} </Message.Footer>
      </Message.Content>
    </Message>
    <Message>
      <Message.Avatar>
        <Avatar>
          <Avatar.Image src="/avatars/02.png" alt="@rabbit" />
          <Avatar.Fallback> {"R"->React.string} </Avatar.Fallback>
        </Avatar>
      </Message.Avatar>
      <Message.Content>
        <Bubble.Group>
          <Bubble variant=Muted>
            <Bubble.Content> {"It's always a one-line change 😭."->React.string} </Bubble.Content>
          </Bubble>
          <Bubble variant=Muted>
            <Bubble.Content> {"Alright, let me take a look."->React.string} </Bubble.Content>
            <Bubble.Reactions ariaLabel="Reactions: thumbs up">
              <span> {"👍"->React.string} </span>
            </Bubble.Reactions>
          </Bubble>
        </Bubble.Group>
      </Message.Content>
    </Message>
    <Marker role="status">
      <Marker.Content className="shimmer">
        <span className="font-medium"> {"Oliver"->React.string} </span>
        {"is typing..."->React.string}
      </Marker.Content>
    </Marker>
  </div>
