@react.component
let make = () =>
  <div className="flex w-full max-w-md flex-col gap-6">
    <Item>
      <Item.Media variant=Item.Media.Variant.Icon>
        <Icons.Inbox />
      </Item.Media>
      <Item.Content>
        <Item.Title> {"Default Variant"->React.string} </Item.Title>
        <Item.Description>
          {"Transparent background with no border."->React.string}
        </Item.Description>
      </Item.Content>
    </Item>
    <Item variant=Item.Variant.Outline>
      <Item.Media variant=Item.Media.Variant.Icon>
        <Icons.Inbox />
      </Item.Media>
      <Item.Content>
        <Item.Title> {"Outline Variant"->React.string} </Item.Title>
        <Item.Description>
          {"Outlined style with a visible border."->React.string}
        </Item.Description>
      </Item.Content>
    </Item>
    <Item variant=Item.Variant.Muted>
      <Item.Media variant=Item.Media.Variant.Icon>
        <Icons.Inbox />
      </Item.Media>
      <Item.Content>
        <Item.Title> {"Muted Variant"->React.string} </Item.Title>
        <Item.Description>
          {"Muted background for secondary content."->React.string}
        </Item.Description>
      </Item.Content>
    </Item>
  </div>
