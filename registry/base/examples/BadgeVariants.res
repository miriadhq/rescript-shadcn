@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex flex-wrap gap-2">
    <Badge> {"Default"->React.string} </Badge>
    <Badge variant=Badge.Variant.Secondary> {"Secondary"->React.string} </Badge>
    <Badge variant=Badge.Variant.Destructive> {"Destructive"->React.string} </Badge>
    <Badge variant=Badge.Variant.Outline> {"Outline"->React.string} </Badge>
    <Badge variant=Badge.Variant.Ghost> {"Ghost"->React.string} </Badge>
  </div>
