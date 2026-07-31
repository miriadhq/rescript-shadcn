@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <InputGroup className="max-w-sm">
    <InputGroup.Input placeholder="Search..." />
    <InputGroup.Addon>
      <Icons.Search className="text-muted-foreground" />
    </InputGroup.Addon>
    <InputGroup.Addon align=InlineEnd>
      <Kbd> {"⌘K"->React.string} </Kbd>
    </InputGroup.Addon>
  </InputGroup>
