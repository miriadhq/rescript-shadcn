@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="grid w-full max-w-sm gap-6">
    <ButtonGroup>
      <ButtonGroup.Text
        render={props =>
          <Label htmlFor="url" className=?props.className>
            {props.children->Option.getOr(React.null)}
          </Label>}
      >
        {"https://"->React.string}
      </ButtonGroup.Text>
      <InputGroup>
        <InputGroup.Input id="url" />
        <InputGroup.Addon align=InlineEnd>
          <Icons.Link2 />
        </InputGroup.Addon>
      </InputGroup>
      <ButtonGroup.Text> {".com"->React.string} </ButtonGroup.Text>
    </ButtonGroup>
  </div>
