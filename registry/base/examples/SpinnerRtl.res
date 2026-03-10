@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex w-full max-w-xs flex-col gap-4 [--radius:1rem]" dir="rtl">
    <Item variant=Item.Variant.Muted dir="rtl">
      <Item.Media>
        <Spinner />
      </Item.Media>
      <Item.Content>
        <Item.Title className="line-clamp-1">
          {"جاري معالجة الدفع..."->React.string}
        </Item.Title>
      </Item.Content>
      <Item.Content className="flex-none justify-end">
        <span className="text-sm tabular-nums"> {"١٠٠.٠٠ دولار"->React.string} </span>
      </Item.Content>
    </Item>
  </div>
