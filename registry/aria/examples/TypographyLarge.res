@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="text-lg font-semibold"> {"Are you absolutely sure?"->React.string} </div>
