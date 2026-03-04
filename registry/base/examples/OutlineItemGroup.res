@react.component
let make = () =>
  <Item.Group>
    <Item variant=Item.Variant.Outline>
      <Item.Media variant=Item.Media.Variant.Icon>
        <Icons.Archive />
      </Item.Media>
      <Item.Content>
        <Item.Title> {"Item 1"->React.string} </Item.Title>
        <Item.Description> {"First item with icon."->React.string} </Item.Description>
      </Item.Content>
    </Item>
    <Item variant=Item.Variant.Outline>
      <Item.Media variant=Item.Media.Variant.Icon>
        <Icons.Archive />
      </Item.Media>
      <Item.Content>
        <Item.Title> {"Item 2"->React.string} </Item.Title>
        <Item.Description> {"Second item with icon."->React.string} </Item.Description>
      </Item.Content>
    </Item>
    <Item variant=Item.Variant.Outline>
      <Item.Media variant=Item.Media.Variant.Icon>
        <Icons.Archive />
      </Item.Media>
      <Item.Content>
        <Item.Title> {"Item 3"->React.string} </Item.Title>
        <Item.Description> {"Third item with icon."->React.string} </Item.Description>
      </Item.Content>
    </Item>
  </Item.Group>
