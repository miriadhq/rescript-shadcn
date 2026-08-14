module Items = {
  @react.component
  let make = () =>
    <div className="flex flex-col gap-1.5 p-1.5">
      {Array.fromInitializer(~length=8, index =>
        <div key={index->Int.toString} className="rounded-lg bg-muted px-3 py-2.5 text-sm">
          {`Item ${(index + 1)->Int.toString}`->React.string}
        </div>
      )->React.array}
    </div>
}

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="mx-auto flex max-w-xs min-w-0 flex-col gap-6">
    <div className="flex flex-col gap-3">
      <div className="overflow-hidden rounded-2xl border">
        <div className="h-48 scroll-fade scrollbar-none overflow-y-auto">
          <Items />
        </div>
      </div>
      <p className="text-center font-mono text-xs text-muted-foreground">
        {"scroll-fade"->React.string}
      </p>
    </div>
    <div className="flex flex-col gap-3">
      <div className="overflow-hidden rounded-2xl border">
        <div className="h-48 scroll-fade scrollbar-none overflow-y-auto scroll-fade-none">
          <Items />
        </div>
      </div>
      <p className="text-center font-mono text-xs text-muted-foreground">
        {"scroll-fade scroll-fade-none"->React.string}
      </p>
    </div>
  </div>
