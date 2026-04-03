module TablerIcons = {
  type props = {className?: string}

  module Plus = {
    @module("@tabler/icons-react")
    external make: React.component<props> = "IconPlus"
  }
}

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <ButtonGroup>
    <Button variant=Secondary> {"Button"->React.string} </Button>
    <ButtonGroup.Separator />
    <Button size=Icon variant=Secondary>
      <TablerIcons.Plus />
    </Button>
  </ButtonGroup>
