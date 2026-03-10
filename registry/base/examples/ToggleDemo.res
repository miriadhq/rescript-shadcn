@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Toggle ariaLabel="Toggle bookmark" size=Toggle.Size.Sm variant=Toggle.Variant.Outline>
    <Icons.Bookmark className="group-aria-pressed/toggle:fill-foreground" />
    {"Bookmark"->React.string}
  </Toggle>
