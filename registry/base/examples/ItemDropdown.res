@@directive("'use client'")

type person = {
  username: string,
  avatar: string,
  email: string,
}

let people = [
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
  <DropdownMenu>
    <DropdownMenu.Trigger render={<Button variant=Outline />}>
      {"Select "->React.string}
      <Icons.ChevronDown />
    </DropdownMenu.Trigger>
    <DropdownMenu.Content className="w-48" align=End>
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
    </DropdownMenu.Content>
  </DropdownMenu>
