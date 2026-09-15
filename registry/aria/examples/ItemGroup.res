type person = {
  username: string,
  avatar: string,
  email: string,
}

let people = [
  {username: "alex", avatar: "/avatars/01.png", email: "alex@example.com"},
  {
    username: "jamie",
    avatar: "/avatars/02.png",
    email: "jamie@example.com",
  },
  {
    username: "taylor",
    avatar: "/avatars/03.png",
    email: "taylor@example.com",
  },
]

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Item.Group className="max-w-sm">
    {people
    ->Array.map(person =>
      <Item key={person.username} variant=Item.Variant.Outline>
        <Item.Media>
          <Avatar>
            <Avatar.Image src={person.avatar} alt="" className="grayscale" />
            <Avatar.Fallback>
              {person.username->String.slice(~start=0, ~end=1)->React.string}
            </Avatar.Fallback>
          </Avatar>
        </Item.Media>
        <Item.Content className="gap-1">
          <Item.Title> {person.username->React.string} </Item.Title>
          <Item.Description> {person.email->React.string} </Item.Description>
        </Item.Content>
        <Item.Actions>
          <Button variant=Ghost size=Icon className="rounded-full">
            <Icons.Plus />
          </Button>
        </Item.Actions>
      </Item>
    )
    ->React.array}
  </Item.Group>
