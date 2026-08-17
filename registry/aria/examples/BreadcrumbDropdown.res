@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Breadcrumb>
    <Breadcrumb.List>
      <Breadcrumb.Item>
        <Breadcrumb.Link href="/"> {"Home"->React.string} </Breadcrumb.Link>
      </Breadcrumb.Item>
      <Breadcrumb.Item>
        <DropdownMenu.Trigger>
          <ReactAria.Button className="flex items-center gap-1">
            {"Components"->React.string}
            <Icons.ChevronDown dataIcon="inline-end" className="size-3.5" />
          </ReactAria.Button>
          <DropdownMenu placement=ReactAria.Common.Placement.BottomStart>
            <DropdownMenu.Group>
              <DropdownMenu.Item> {"Documentation"->React.string} </DropdownMenu.Item>
              <DropdownMenu.Item> {"Themes"->React.string} </DropdownMenu.Item>
              <DropdownMenu.Item> {"GitHub"->React.string} </DropdownMenu.Item>
            </DropdownMenu.Group>
          </DropdownMenu>
        </DropdownMenu.Trigger>
      </Breadcrumb.Item>
      <Breadcrumb.Item>
        <Breadcrumb.Page> {"Breadcrumb"->React.string} </Breadcrumb.Page>
      </Breadcrumb.Item>
    </Breadcrumb.List>
  </Breadcrumb>
