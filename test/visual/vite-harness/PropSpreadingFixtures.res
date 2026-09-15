// Keep the public ReScript call sites covered, in addition to JS prop-forwarding checks.
let navigation =
  <Base.NavigationMenu delay=250 closeDelay=100 onOpenChangeComplete={_ => ()}>
    <Base.NavigationMenu.List>
      <Base.NavigationMenu.Item value="docs" title="Docs">
        <Base.NavigationMenu.Trigger onPointerDown={_ => ()}>
          {React.string("Docs")}
        </Base.NavigationMenu.Trigger>
        <Base.NavigationMenu.Content>
          <Base.NavigationMenu.Link href="/docs" active=true closeOnClick=true>
            {React.string("Documentation")}
          </Base.NavigationMenu.Link>
        </Base.NavigationMenu.Content>
      </Base.NavigationMenu.Item>
    </Base.NavigationMenu.List>
  </Base.NavigationMenu>

let tabs =
  <Base.Tabs defaultValue="one">
    <Base.Tabs.List activateOnFocus=true loopFocus=false variant=Line>
      <Base.Tabs.Trigger value="one" title="First"> {React.string("One")} </Base.Tabs.Trigger>
    </Base.Tabs.List>
    <Base.Tabs.Content value="one" keepMounted=true dataTestId="kept-panel">
      {React.string("Panel")}
    </Base.Tabs.Content>
  </Base.Tabs>

let slider =
  <Base.Slider
    value=25. minStepsBetweenValues=2. thumbCollisionBehavior=Push onValueCommitted={(_, _) => ()}
  />
let radio =
  <Base.RadioGroup inputRef={React.createRef()->ReactDOM.Ref.domRef} name="choice">
    <Base.RadioGroup.Item value="one" title="First" />
  </Base.RadioGroup>
let command =
  <Base.Command>
    <Base.Command.Item title="Run command" keywords=["run"] forceMount=true onSelect={_ => ()}>
      {React.string("Run")}
    </Base.Command.Item>
  </Base.Command>
let field = <Base.Field orientation=Responsive dataTestId="responsive-field" />
let attachment = <Base.Attachment size=Sm orientation=Vertical state=Done title="Attachment" />
