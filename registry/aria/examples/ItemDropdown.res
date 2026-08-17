@@directive("'use client'")

module Person = {
  type t = {
    username: string,
    avatar: string,
    email: string,
  }
}

let people: array<Person.t> = [
  {username: "shadcn", avatar: "https://github.com/shadcn.png", email: "shadcn@vercel.com"},
  {
    username: "maxleiter",
    avatar: "https://github.com/maxleiter.png",
    email: "maxleiter@vercel.com",
  },
  {
    username: "evilrabbit",
    avatar: "https://github.com/evilrabbit.png",
    email: "evilrabbit@vercel.com",
  },
]

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <DropdownMenu.Trigger>
    <Button variant=Outline>
      {"Select "->React.string}
      <Icons.ChevronDown />
    </Button>
    <DropdownMenu className="w-48" placement=ReactAria.Common.Placement.BottomEnd>
      <DropdownMenu.Group>
        {people
        ->Array.map(person =>
          <DropdownMenu.Item key={person.username}>
            <Item size=Item.Size.Xs className="w-full p-2">
              <Item.Media>
                <Avatar className="size-[--spacing(6.5)]">
                  <Avatar.Image src={person.avatar} className="grayscale" />
                  <Avatar.Fallback>
                    {person.username->String.slice(~start=0, ~end=1)->React.string}
                  </Avatar.Fallback>
                </Avatar>
              </Item.Media>
              <Item.Content className="gap-0">
                <Item.Title> {person.username->React.string} </Item.Title>
                <Item.Description className="leading-none">
                  {person.email->React.string}
                </Item.Description>
              </Item.Content>
            </Item>
          </DropdownMenu.Item>
        )
        ->React.array}
      </DropdownMenu.Group>
    </DropdownMenu>
  </DropdownMenu.Trigger>
