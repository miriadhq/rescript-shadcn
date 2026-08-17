@@directive("'use client'")

@module("sonner") external toast: string => unit = "toast"

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (country, setCountry) = React.useState(() => "+1")

  <Field.Group>
    <Field>
      <Field.Label htmlFor="input-tooltip-20"> {"Tooltip"->React.string} </Field.Label>
      <InputGroup>
        <InputGroup.Input id="input-tooltip-20" />
        <InputGroup.Addon align=InlineEnd>
          <Tooltip.Trigger>
            <InputGroup.Button className="rounded-full" size=IconXs>
              <Icons.Info />
            </InputGroup.Button>
            <Tooltip> {"This is content in a tooltip."->React.string} </Tooltip>
          </Tooltip.Trigger>
        </InputGroup.Addon>
      </InputGroup>
      <Field.Description>
        {"This is a description of the input group."->React.string}
      </Field.Description>
    </Field>
    <Field>
      <Field.Label htmlFor="input-dropdown-21"> {"Dropdown"->React.string} </Field.Label>
      <InputGroup>
        <InputGroup.Input id="input-dropdown-21" />
        <InputGroup.Addon>
          <DropdownMenu.Trigger>
            <InputGroup.Button className="text-muted-foreground tabular-nums">
              {country->React.string}
              <Icons.ChevronDown />
            </InputGroup.Button>
            <DropdownMenu
              placement=ReactAria.Common.Placement.BottomStart
              className="min-w-16"
              offset=10.
              crossOffset={-8.}
            >
              <DropdownMenu.Item onClick={_ => setCountry(_ => "+1")}>
                {"+1"->React.string}
              </DropdownMenu.Item>
              <DropdownMenu.Item onClick={_ => setCountry(_ => "+44")}>
                {"+44"->React.string}
              </DropdownMenu.Item>
              <DropdownMenu.Item onClick={_ => setCountry(_ => "+46")}>
                {"+46"->React.string}
              </DropdownMenu.Item>
            </DropdownMenu>
          </DropdownMenu.Trigger>
        </InputGroup.Addon>
      </InputGroup>
      <Field.Description>
        {"This is a description of the input group."->React.string}
      </Field.Description>
    </Field>
    <Field>
      <Field.Label htmlFor="input-secure-19"> {"Popover"->React.string} </Field.Label>
      <InputGroup>
        <Popover.Trigger>
          <InputGroup.Addon>
            <InputGroup.Button variant=Secondary size=IconXs>
              <Icons.Info />
            </InputGroup.Button>
          </InputGroup.Addon>
          <Popover placement=ReactAria.Common.Placement.BottomStart>
            <Popover.Header>
              <Popover.Title> {"Your connection is not secure."->React.string} </Popover.Title>
              <Popover.Description>
                {"You should not enter any sensitive information on this site."->React.string}
              </Popover.Description>
            </Popover.Header>
          </Popover>
        </Popover.Trigger>
        <InputGroup.Addon className="pl-1 text-muted-foreground">
          {"https://"->React.string}
        </InputGroup.Addon>
        <InputGroup.Input id="input-secure-19" />
        <InputGroup.Addon align=InlineEnd>
          <InputGroup.Button size=IconXs onClick={_ => toast("Added to favorites")}>
            <Icons.Star />
          </InputGroup.Button>
        </InputGroup.Addon>
      </InputGroup>
      <Field.Description>
        {"This is a description of the input group."->React.string}
      </Field.Description>
    </Field>
    <Field>
      <Field.Label htmlFor="url"> {"Button Group"->React.string} </Field.Label>
      <ButtonGroup>
        <ButtonGroup.Text> {"https://"->React.string} </ButtonGroup.Text>
        <InputGroup>
          <InputGroup.Input id="url" />
          <InputGroup.Addon align=InlineEnd>
            <Icons.Info />
          </InputGroup.Addon>
        </InputGroup>
        <ButtonGroup.Text> {".com"->React.string} </ButtonGroup.Text>
      </ButtonGroup>
      <Field.Description>
        {"This is a description of the input group."->React.string}
      </Field.Description>
    </Field>
  </Field.Group>
}
