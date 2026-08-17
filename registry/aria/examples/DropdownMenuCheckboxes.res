@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (selectedKeys, setSelectedKeys) = React.useState(() => ["status-bar"])
  <DropdownMenu.Trigger>
    <Button variant=Outline className="w-fit"> {"Checkboxes"->React.string} </Button>
    <DropdownMenu className="min-w-40">
      <DropdownMenu.Group
        selectionMode=Multiple
        selectedKeys
        onSelectionChange={selection =>
          switch selection {
          | ReactAria.Common.Selection.Keys(keys) =>
            setSelectedKeys(_ => keys->Set.values->IteratorObject.toArray)
          | ReactAria.Common.Selection.All => ()
          }}
      >
        <DropdownMenu.Label> {"Appearance"->React.string} </DropdownMenu.Label>
        <DropdownMenu.Item id="status-bar">
          <Icons.Layout />
          {"Status Bar"->React.string}
        </DropdownMenu.Item>
        <DropdownMenu.Item id="activity-bar" isDisabled=true>
          <Icons.Circle />
          {"Activity Bar"->React.string}
        </DropdownMenu.Item>
        <DropdownMenu.Item id="panel">
          <Icons.PanelLeft />
          {"Panel"->React.string}
        </DropdownMenu.Item>
      </DropdownMenu.Group>
    </DropdownMenu>
  </DropdownMenu.Trigger>
}
