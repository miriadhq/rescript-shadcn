@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex w-full max-w-md flex-col gap-4">
    <Item render={<a href="#" />}>
      <Item.Content>
        <Item.Title> {"Visit our documentation"->React.string} </Item.Title>
        <Item.Description>
          {"Learn how to get started with our components."->React.string}
        </Item.Description>
      </Item.Content>
      <Item.Actions>
        <Icons.ChevronRight className="size-4" />
      </Item.Actions>
    </Item>
    <Item
      variant=Item.Variant.Outline render={<a href="#" target="_blank" rel="noopener noreferrer" />}
    >
      <Item.Content>
        <Item.Title> {"External resource"->React.string} </Item.Title>
        <Item.Description>
          {"Opens in a new tab with security attributes."->React.string}
        </Item.Description>
      </Item.Content>
      <Item.Actions>
        <Icons.ExternalLink className="size-4" />
      </Item.Actions>
    </Item>
  </div>
