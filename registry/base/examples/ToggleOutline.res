@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex flex-wrap items-center gap-2">
    <Toggle variant=Toggle.Variant.Outline ariaLabel="Toggle italic">
      <Icons.Italic />
      {"Italic"->React.string}
    </Toggle>
    <Toggle variant=Toggle.Variant.Outline ariaLabel="Toggle bold">
      <Icons.Bold />
      {"Bold"->React.string}
    </Toggle>
  </div>
