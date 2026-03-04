@react.component
let make = () =>
  <Item.Group>
    <Item variant=Item.Variant.Muted>
      <Item.Content>
        <Item.Title> {"Item 1"->React.string} </Item.Title>
        <Item.Description> {"First item in muted group."->React.string} </Item.Description>
      </Item.Content>
      <Item.Actions>
        <Button variant=Button.Variant.Outline size=Button.Size.Sm>
          {"Action"->React.string}
        </Button>
      </Item.Actions>
    </Item>
    <Item variant=Item.Variant.Muted>
      <Item.Content>
        <Item.Title> {"Item 2"->React.string} </Item.Title>
        <Item.Description> {"Second item in muted group."->React.string} </Item.Description>
      </Item.Content>
      <Item.Actions>
        <Button variant=Button.Variant.Outline size=Button.Size.Sm>
          {"Action"->React.string}
        </Button>
      </Item.Actions>
    </Item>
    <Item variant=Item.Variant.Muted>
      <Item.Content>
        <Item.Title> {"Item 3"->React.string} </Item.Title>
        <Item.Description> {"Third item in muted group."->React.string} </Item.Description>
      </Item.Content>
      <Item.Actions>
        <Button variant=Button.Variant.Outline size=Button.Size.Sm>
          {"Action"->React.string}
        </Button>
      </Item.Actions>
    </Item>
  </Item.Group>
