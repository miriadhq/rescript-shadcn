@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex w-full max-w-sm flex-col gap-6 py-12">
    <Message.Group>
      <Message>
        <Message.Avatar />
        <Message.Content>
          <Bubble variant=Muted>
            <Bubble.Content> {"I checked the registry addresses."->React.string} </Bubble.Content>
          </Bubble>
        </Message.Content>
      </Message>
      <Message>
        <Message.Avatar>
          <Avatar>
            <Avatar.Image src="/avatars/02.png" alt="@avatar" />
            <Avatar.Fallback> {"CN"->React.string} </Avatar.Fallback>
          </Avatar>
        </Message.Avatar>
        <Message.Content>
          <Bubble variant=Muted>
            <Bubble.Content>
              {"The component and example JSON now live under the UI registry."->React.string}
            </Bubble.Content>
          </Bubble>
        </Message.Content>
      </Message>
    </Message.Group>
  </div>
