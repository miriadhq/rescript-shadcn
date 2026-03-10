@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex flex-wrap items-center gap-2 md:flex-row">
    <Button variant=Button.Variant.Outline> {"Button"->React.string} </Button>
    <Button variant=Button.Variant.Outline size=Button.Size.Icon ariaLabel="Submit">
      <Icons.ArrowUp />
    </Button>
  </div>
