@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex w-full max-w-xs flex-col gap-6">
    <InputGroup>
      <InputGroup.Input placeholder="Search..." />
      <InputGroup.Addon>
        <Icons.Search />
      </InputGroup.Addon>
      <InputGroup.Addon align=InlineEnd>
        <Kbd> {"⌘"->React.string} </Kbd>
        <Kbd> {"K"->React.string} </Kbd>
      </InputGroup.Addon>
    </InputGroup>
  </div>
