@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex w-full flex-wrap justify-center gap-2">
    <Badge> {"Badge"->React.string} </Badge>
    <Badge variant=Secondary> {"Secondary"->React.string} </Badge>
    <Badge variant=Destructive> {"Destructive"->React.string} </Badge>
    <Badge variant=Outline> {"Outline"->React.string} </Badge>
  </div>
