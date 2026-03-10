@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex w-full max-w-lg flex-col gap-6">
    <Item variant=Item.Variant.Outline>
      <Item.Media variant=Item.Media.Variant.Icon>
        <Icons.ShieldAlert />
      </Item.Media>
      <Item.Content>
        <Item.Title> {"Security Alert"->React.string} </Item.Title>
        <Item.Description>
          {"New login detected from unknown device."->React.string}
        </Item.Description>
      </Item.Content>
      <Item.Actions>
        <Button size=Button.Size.Sm variant=Button.Variant.Outline>
          {"Review"->React.string}
        </Button>
      </Item.Actions>
    </Item>
  </div>
