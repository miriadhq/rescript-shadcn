@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (value, setValue) = React.useState(() => [200., 800.])

  <Field className="w-full max-w-xs">
    <Field.Title> {"Price Range"->React.string} </Field.Title>
    <Field.Description>
      {"Set your budget range ($"->React.string}
      <span className="font-medium tabular-nums">
        {value->Array.get(0)->Option.getOr(0.)->Float.toInt->Int.toString->React.string}
      </span>
      {" - "->React.string}
      <span className="font-medium tabular-nums">
        {value->Array.get(1)->Option.getOr(0.)->Float.toInt->Int.toString->React.string}
      </span>
      {")."->React.string}
    </Field.Description>
    <Slider
      value={value}
      onValueChange={(v, _) => setValue(_ => v)}
      max={1000.}
      min={0.}
      step={10.}
      className="mt-2 w-full"
      ariaLabel="Price Range"
    />
  </Field>
}
