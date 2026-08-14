@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  <ButtonGroup>
    <Button variant=Outline>
      <Icons.Bot />
      {"Copilot"->React.string}
    </Button>
    <Popover.Trigger>
      <Button variant=Outline size=Icon ariaLabel="Open Popover">
        <Icons.ChevronDown />
      </Button>
      <Popover placement=ReactAria.Common.BottomEnd className="rounded-xl text-sm">
        <Popover.Header>
          <Popover.Title> {"Start a new task with Copilot"->React.string} </Popover.Title>
          <Popover.Description>
            {"Describe your task in natural language."->React.string}
          </Popover.Description>
        </Popover.Header>
        <Field>
          <Field.Label htmlFor="task" className="sr-only">
            {"Task Description"->React.string}
          </Field.Label>
          <Textarea id="task" placeholder="I need to..." className="resize-none" />
          <Field.Description>
            {"Copilot will open a pull request for review."->React.string}
          </Field.Description>
        </Field>
      </Popover>
    </Popover.Trigger>
  </ButtonGroup>
}
