@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <h4 className="scroll-m-20 text-xl font-semibold tracking-tight">
    {"People stopped telling jokes"->React.string}
  </h4>
