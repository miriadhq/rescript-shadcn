@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <ToggleGroup variant=ToggleGroup.Variant.Outline defaultValue={["list"]} dir="rtl">
    <ToggleGroup.Item value="list" ariaLabel="قائمة">
      {"قائمة"->React.string}
    </ToggleGroup.Item>
    <ToggleGroup.Item value="grid" ariaLabel="شبكة">
      {"شبكة"->React.string}
    </ToggleGroup.Item>
    <ToggleGroup.Item value="cards" ariaLabel="بطاقات">
      {"بطاقات"->React.string}
    </ToggleGroup.Item>
  </ToggleGroup>
