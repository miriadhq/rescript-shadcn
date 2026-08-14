@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (position, setPosition) = React.useState(() => "bottom")
  <DropdownMenu.Trigger>
    <Button variant=Outline className="w-fit"> {"Radio Group"->React.string} </Button>
    <DropdownMenu>
      <DropdownMenu.Group
        selectionMode=Single
        selectedKeys={[position]}
        onSelectionChange={selection =>
          switch selection {
          | ReactAria.Common.Keys(keys) =>
            setPosition(_ => keys->Set.values->Iterator.toArray->Array.get(0)->Option.getOr("bottom"))
          | ReactAria.Common.All => setPosition(_ => "bottom")
          }
        }
      >
        <DropdownMenu.Label> {"Panel Position"->React.string} </DropdownMenu.Label>
        <DropdownMenu.Item id="top">
          <Icons.ArrowUp />
          {"Top"->React.string}
        </DropdownMenu.Item>
        <DropdownMenu.Item id="bottom">
          <Icons.ArrowDown />
          {"Bottom"->React.string}
        </DropdownMenu.Item>
        <DropdownMenu.Item id="right" isDisabled=true>
          <Icons.ArrowRight />
          {"Right"->React.string}
        </DropdownMenu.Item>
      </DropdownMenu.Group>
    </DropdownMenu>
  </DropdownMenu.Trigger>
}
