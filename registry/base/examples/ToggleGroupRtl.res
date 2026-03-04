@@directive("'use client'")

@react.component
let make = () =>
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
