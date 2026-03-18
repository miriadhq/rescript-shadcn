@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Avatar>
    <Avatar.Image src="https://github.com/shadcn.png" alt="@shadcn" />
    <Avatar.Fallback> {"CN"->React.string} </Avatar.Fallback>
    <Avatar.Badge className="bg-green-600 dark:bg-green-800" />
  </Avatar>
