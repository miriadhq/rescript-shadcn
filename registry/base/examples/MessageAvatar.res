@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex w-full max-w-sm flex-col gap-6 py-12">
    <Message>
      <Message.Avatar>
        <Avatar>
          <Avatar.Image src="/avatars/03.png" alt="@avatar" />
          <Avatar.Fallback> {"R"->React.string} </Avatar.Fallback>
        </Avatar>
      </Message.Avatar>
      <Message.Content>
        <Bubble variant=Muted>
          <Bubble.Content>
            {"The build failed during dependency installation."->React.string}
          </Bubble.Content>
        </Bubble>
      </Message.Content>
    </Message>
    <Message align=End>
      <Message.Avatar>
        <Avatar>
          <Avatar.Image src="/avatars/10.png" alt="@avatar" />
          <Avatar.Fallback> {"R"->React.string} </Avatar.Fallback>
        </Avatar>
      </Message.Avatar>
      <Message.Content>
        <Bubble>
          <Bubble.Content> {"Can you share the exact error?"->React.string} </Bubble.Content>
        </Bubble>
      </Message.Content>
    </Message>
    <Message>
      <Message.Avatar>
        <Avatar>
          <Avatar.Image src="/avatars/03.png" alt="@avatar" />
          <Avatar.Fallback> {"R"->React.string} </Avatar.Fallback>
        </Avatar>
      </Message.Avatar>
      <Message.Content>
        <Bubble.Group>
          <Bubble variant=Muted>
            <Bubble.Content> {"Here's the error from the logs"->React.string} </Bubble.Content>
          </Bubble>
          <Bubble variant=Muted>
            <Bubble.Content>
              {"Something went wrong with the build. The libraries are not installed correctly. Try running the build again."->React.string}
            </Bubble.Content>
          </Bubble>
        </Bubble.Group>
      </Message.Content>
    </Message>
  </div>
