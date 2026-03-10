@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Avatar>
    <Avatar.Image src="https://github.com/shadcn.png" alt="@shadcn" className="grayscale" />
    <Avatar.Fallback> {"CN"->React.string} </Avatar.Fallback>
  </Avatar>
