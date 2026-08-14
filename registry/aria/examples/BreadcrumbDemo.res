@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Breadcrumb>
    <Breadcrumb.List>
      <Breadcrumb.Item>
        <Breadcrumb.Link href="#"> {"Home"->React.string} </Breadcrumb.Link>
      </Breadcrumb.Item>
      <Breadcrumb.Item>
        <DropdownMenu.Trigger>
<Button size=IconSm variant=Ghost>
            <Breadcrumb.Ellipsis />
            <span className="sr-only"> {"Toggle menu"->React.string} </span>
          </Button>
<DropdownMenu placement=ReactAria.Common.BottomStart>
            <DropdownMenu.Group>
              <DropdownMenu.Item> {"Documentation"->React.string} </DropdownMenu.Item>
              <DropdownMenu.Item> {"Themes"->React.string} </DropdownMenu.Item>
              <DropdownMenu.Item> {"GitHub"->React.string} </DropdownMenu.Item>
            </DropdownMenu.Group>
          </DropdownMenu>
</DropdownMenu.Trigger>
      </Breadcrumb.Item>
      <Breadcrumb.Item>
        <Breadcrumb.Link href="#"> {"Components"->React.string} </Breadcrumb.Link>
      </Breadcrumb.Item>
      <Breadcrumb.Item>
        <Breadcrumb.Page> {"Breadcrumb"->React.string} </Breadcrumb.Page>
      </Breadcrumb.Item>
    </Breadcrumb.List>
  </Breadcrumb>
