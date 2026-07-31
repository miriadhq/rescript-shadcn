@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex flex-wrap items-center gap-2 md:flex-row">
    <Button variant=Outline> {"Button"->React.string} </Button>
    <Button variant=Outline size=Icon ariaLabel="Submit">
      <Icons.ArrowUp />
    </Button>
  </div>
