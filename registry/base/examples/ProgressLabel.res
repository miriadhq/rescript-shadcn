@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Progress value={56.} className="w-full max-w-sm">
    <Progress.Label> {"Upload progress"->React.string} </Progress.Label>
    <Progress.Value />
  </Progress>
