@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex gap-2">
    <Button className="rounded-full"> {"Get Started"->React.string} </Button>
    <Button variant=Button.Variant.Outline size=Button.Size.Icon className="rounded-full">
      <Icons.ArrowUp />
    </Button>
  </div>
