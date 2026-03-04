@react.component
let make = () =>
  <div className="flex w-full max-w-md flex-col gap-6">
    <Item variant=Item.Variant.Outline>
      <Item.Media variant=Item.Media.Variant.Icon>
        <Icons.Inbox />
      </Item.Media>
      <Item.Content>
        <Item.Title> {"Default Size"->React.string} </Item.Title>
        <Item.Description>
          {"The standard size for most use cases."->React.string}
        </Item.Description>
      </Item.Content>
    </Item>
    <Item variant=Item.Variant.Outline size=Item.Size.Sm>
      <Item.Media variant=Item.Media.Variant.Icon>
        <Icons.Inbox />
      </Item.Media>
      <Item.Content>
        <Item.Title> {"Small Size"->React.string} </Item.Title>
        <Item.Description> {"A compact size for dense layouts."->React.string} </Item.Description>
      </Item.Content>
    </Item>
    <Item variant=Item.Variant.Outline size=Item.Size.Xs>
      <Item.Media variant=Item.Media.Variant.Icon>
        <Icons.Inbox />
      </Item.Media>
      <Item.Content>
        <Item.Title> {"Extra Small Size"->React.string} </Item.Title>
        <Item.Description> {"The most compact size available."->React.string} </Item.Description>
      </Item.Content>
    </Item>
  </div>
