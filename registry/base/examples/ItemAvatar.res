@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex w-full max-w-lg flex-col gap-6">
    <Item variant=Item.Variant.Outline>
      <Item.Media>
        <Avatar className="size-10">
          <Avatar.Image src="https://github.com/evilrabbit.png" alt="" />
          <Avatar.Fallback> {"ER"->React.string} </Avatar.Fallback>
        </Avatar>
      </Item.Media>
      <Item.Content>
        <Item.Title> {"Evil Rabbit"->React.string} </Item.Title>
        <Item.Description> {"Last seen 5 months ago"->React.string} </Item.Description>
      </Item.Content>
      <Item.Actions>
        <Button
          size=Button.Size.IconSm
          variant=Button.Variant.Outline
          className="rounded-full"
          ariaLabel="Invite"
        >
          <Icons.Plus />
        </Button>
      </Item.Actions>
    </Item>
    <Item variant=Item.Variant.Outline>
      <Item.Media>
        <div
          className="*:data-[slot=avatar]:ring-background flex -space-x-2 *:data-[slot=avatar]:ring-2 *:data-[slot=avatar]:grayscale"
        >
          <Avatar className="hidden sm:flex">
            <Avatar.Image src="https://github.com/shadcn.png" alt="@shadcn" />
            <Avatar.Fallback> {"CN"->React.string} </Avatar.Fallback>
          </Avatar>
          <Avatar className="hidden sm:flex">
            <Avatar.Image src="https://github.com/maxleiter.png" alt="@maxleiter" />
            <Avatar.Fallback> {"LR"->React.string} </Avatar.Fallback>
          </Avatar>
          <Avatar>
            <Avatar.Image src="https://github.com/evilrabbit.png" alt="@evilrabbit" />
            <Avatar.Fallback> {"ER"->React.string} </Avatar.Fallback>
          </Avatar>
        </div>
      </Item.Media>
      <Item.Content>
        <Item.Title> {"No Team Members"->React.string} </Item.Title>
        <Item.Description>
          {"Invite your team to collaborate on this project."->React.string}
        </Item.Description>
      </Item.Content>
      <Item.Actions>
        <Button size=Button.Size.Sm variant=Button.Variant.Outline>
          {"Invite"->React.string}
        </Button>
      </Item.Actions>
    </Item>
  </div>
