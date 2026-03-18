@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Button variant=Button.Variant.Outline>
    {"Accept "->React.string}
    <Kbd dataIcon="inline-end" className="translate-x-0.5"> {"⏎"->React.string} </Kbd>
  </Button>
