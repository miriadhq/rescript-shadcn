@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <h3 className="scroll-m-20 text-2xl font-semibold tracking-tight">
    {"The Joke Tax"->React.string}
  </h3>
