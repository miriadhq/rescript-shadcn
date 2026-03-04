@@directive("'use client'")

@react.component
let make = () =>
  <Toggle ariaLabel="Toggle bookmark" size=Toggle.Size.Sm variant=Toggle.Variant.Outline dir="rtl">
    <Icons.Bookmark className="group-aria-pressed/toggle:fill-foreground" />
    {"إشارة مرجعية"->React.string}
  </Toggle>
