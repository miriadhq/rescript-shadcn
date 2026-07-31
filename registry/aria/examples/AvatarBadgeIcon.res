@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Avatar className="grayscale">
    <Avatar.Image src="https://github.com/pranathip.png" alt="@pranathip" />
    <Avatar.Fallback> {"PP"->React.string} </Avatar.Fallback>
    <Avatar.Badge>
      <Icons.Plus />
    </Avatar.Badge>
  </Avatar>
