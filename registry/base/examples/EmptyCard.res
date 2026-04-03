@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Empty>
    <Empty.Header>
      <Empty.Media variant=Empty.Variant.Icon>
        <Icons.Folder />
      </Empty.Media>
      <Empty.Title> {"No projects yet"->React.string} </Empty.Title>
      <Empty.Description>
        {"You haven't created any projects yet. Get started by creating your first project."->React.string}
      </Empty.Description>
    </Empty.Header>
    <Empty.Content>
      <div className="flex gap-2">
        <Button render={<a href="#" />} nativeButton={false}>
          {"Create project"->React.string}
        </Button>
        <Button variant=Outline> {"Import project"->React.string} </Button>
      </div>
      <Button
        variant=Link render={<a href="#" />} className="text-muted-foreground" nativeButton={false}
      >
        {"Learn more"->React.string}
        <Icons.ArrowUpRight />
      </Button>
    </Empty.Content>
  </Empty>
