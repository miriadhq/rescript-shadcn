@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="mx-auto w-full max-w-xs overflow-hidden rounded-2xl border">
    <div className="h-72 scroll-fade scrollbar-none overflow-y-auto">
      <div className="flex flex-col gap-1.5 p-1.5">
        {Array.fromInitializer(~length=12, index =>
          <div key={index->Int.toString} className="rounded-lg bg-muted px-3 py-2.5 text-sm">
            {`Item ${(index + 1)->Int.toString}`->React.string}
          </div>
        )->React.array}
      </div>
    </div>
  </div>
