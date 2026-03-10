@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (isOpen, setIsOpen) = React.useState(() => false)

  <Collapsible
    open_={isOpen}
    onOpenChange={(open_, _) => setIsOpen(_ => open_)}
    className="flex w-[350px] flex-col gap-2"
    dir="rtl"
  >
    <div className="flex items-center justify-between gap-4 px-4">
      <h4 className="text-sm font-semibold"> {"الطلب #4189"->React.string} </h4>
      <Collapsible.Trigger
        render={<Button variant=Button.Variant.Ghost size=Button.Size.Icon className="size-8" />}
      >
        <Icons.ChevronsUpDown />
        <span className="sr-only"> {"Toggle details"->React.string} </span>
      </Collapsible.Trigger>
    </div>
    <div className="flex items-center justify-between rounded-md border px-4 py-2 text-sm">
      <span className="text-muted-foreground"> {"الحالة"->React.string} </span>
      <span className="font-medium"> {"تم الشحن"->React.string} </span>
    </div>
    <Collapsible.Content className="flex flex-col gap-2">
      <div className="rounded-md border px-4 py-2 text-sm">
        <p className="font-medium"> {"عنوان الشحن"->React.string} </p>
        <p className="text-muted-foreground"> {"100 Market St, San Francisco"->React.string} </p>
      </div>
      <div className="rounded-md border px-4 py-2 text-sm">
        <p className="font-medium"> {"العناصر"->React.string} </p>
        <p className="text-muted-foreground">
          {"2x سماعات الاستوديو"->React.string}
        </p>
      </div>
    </Collapsible.Content>
  </Collapsible>
}
