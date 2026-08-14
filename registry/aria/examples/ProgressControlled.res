@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (value, setValue) = React.useState(() => 50.)

  <div className="flex w-full max-w-sm flex-col gap-4">
    <Progress ariaLabel="Loading" value className="w-full" />
    <Slider
      ariaLabel="Progress"
      value
      onChange={nextValue => setValue(_ => nextValue)}
      minValue={0.}
      maxValue={100.}
      step={1.}
    />
  </div>
}
