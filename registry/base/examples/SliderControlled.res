@@directive("'use client'")

@react.component
let make = () => {
  let (value, setValue) = React.useState(() => [0.3, 0.7])

  <div className="mx-auto grid w-full max-w-xs gap-3">
    <div className="flex items-center justify-between gap-2">
      <Label htmlFor="slider-demo-temperature"> {"Temperature"->React.string} </Label>
      <span className="text-muted-foreground text-sm">
        {value->Array.map(v => Float.toString(v))->Array.join(", ")->React.string}
      </span>
    </div>
    <Slider
      id="slider-demo-temperature"
      value
      onValueChange={(v, _) => setValue(_ => v)}
      min={0.}
      max={1.}
      step={0.1}
    >
      {React.null}
    </Slider>
  </div>
}
