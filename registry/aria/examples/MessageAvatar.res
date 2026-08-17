@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex w-full max-w-md flex-col gap-8">
    <Message>
      <Message.Avatar>
        <Avatar>
          <Avatar.Image src="https://github.com/shadcn.png" alt="@shadcn" className="grayscale" />
          <Avatar.Fallback> {"CN"->React.string} </Avatar.Fallback>
        </Avatar>
      </Message.Avatar>
      <Message.Content>
        <Bubble variant=Muted>
          <Bubble.Content> {"Something went wrong. Any idea?"->React.string} </Bubble.Content>
        </Bubble>
      </Message.Content>
    </Message>
    <Message align=End>
      <Message.Avatar>
        <Avatar>
          <Avatar.Image
            src="https://github.com/evilrabbit.png" alt="@evilrabbit" className="grayscale"
          />
          <Avatar.Fallback> {"ER"->React.string} </Avatar.Fallback>
        </Avatar>
      </Message.Avatar>
      <Message.Content>
        <Bubble>
          <Bubble.Content>
            {"I found the failed dependency install."->React.string}
          </Bubble.Content>
        </Bubble>
      </Message.Content>
    </Message>
  </div>
