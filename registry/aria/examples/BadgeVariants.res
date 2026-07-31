@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex flex-wrap gap-2">
    <Badge> {"Default"->React.string} </Badge>
    <Badge variant=Secondary> {"Secondary"->React.string} </Badge>
    <Badge variant=Destructive> {"Destructive"->React.string} </Badge>
    <Badge variant=Outline> {"Outline"->React.string} </Badge>
    <Badge variant=Ghost> {"Ghost"->React.string} </Badge>
  </div>
