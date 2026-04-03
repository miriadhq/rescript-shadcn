@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex flex-col items-start gap-8">
    <ButtonGroup>
      <Button variant=Outline size=Sm> {"Small"->React.string} </Button>
      <Button variant=Outline size=Sm> {"Button"->React.string} </Button>
      <Button variant=Outline size=Sm> {"Group"->React.string} </Button>
      <Button variant=Outline size=IconSm>
        <Icons.Plus />
      </Button>
    </ButtonGroup>
    <ButtonGroup>
      <Button variant=Outline> {"Default"->React.string} </Button>
      <Button variant=Outline> {"Button"->React.string} </Button>
      <Button variant=Outline> {"Group"->React.string} </Button>
      <Button variant=Outline size=Icon>
        <Icons.Plus />
      </Button>
    </ButtonGroup>
    <ButtonGroup>
      <Button variant=Outline size=Lg> {"Large"->React.string} </Button>
      <Button variant=Outline size=Lg> {"Button"->React.string} </Button>
      <Button variant=Outline size=Lg> {"Group"->React.string} </Button>
      <Button variant=Outline size=IconLg>
        <Icons.Plus />
      </Button>
    </ButtonGroup>
  </div>
