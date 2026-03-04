@react.component
let make = () =>
  <div className="flex flex-wrap items-center gap-2">
    <Toggle variant=Toggle.Variant.Outline ariaLabel="Toggle small" size=Toggle.Size.Sm>
      {"Small"->React.string}
    </Toggle>
    <Toggle variant=Toggle.Variant.Outline ariaLabel="Toggle default" size=Toggle.Size.Default>
      {"Default"->React.string}
    </Toggle>
    <Toggle variant=Toggle.Variant.Outline ariaLabel="Toggle large" size=Toggle.Size.Lg>
      {"Large"->React.string}
    </Toggle>
  </div>
