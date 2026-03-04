@react.component
let make = () =>
  <Empty>
    <Empty.Header>
      <Empty.Title> {"404 - Not Found"->React.string} </Empty.Title>
      <Empty.Description>
        {"The page you're looking for doesn't exist. Try searching for what you need below."->React.string}
      </Empty.Description>
    </Empty.Header>
    <Empty.Content>
      <InputGroup className="sm:w-3/4">
        <InputGroup.Input placeholder="Try searching for pages..." />
        <InputGroup.Addon>
          <Icons.Search />
        </InputGroup.Addon>
        <InputGroup.Addon align=InlineEnd>
          <Kbd> {"/"->React.string} </Kbd>
        </InputGroup.Addon>
      </InputGroup>
      <Empty.Description>
        {"Need help? "->React.string}
        <a href="#"> {"Contact support"->React.string} </a>
      </Empty.Description>
    </Empty.Content>
  </Empty>
