@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (value, setValue) = React.useState(() => 50.)

  <div className="flex w-full max-w-sm flex-col gap-4">
    <Progress value className="w-full" />
    <Slider
      value onValueChange={(nextValue, _) => setValue(_ => nextValue)} min={0.} max={100.} step={1.}
    />
  </div>
}
