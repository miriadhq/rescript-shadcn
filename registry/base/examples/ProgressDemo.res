@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (progress, setProgress) = React.useState(() => 13.)

  React.useEffect0(() => {
    let timer = setTimeout(() => setProgress(_ => 66.), 500)
    Some(() => clearTimeout(timer))
  })

  <Progress value=progress className="w-[60%]" />
}
