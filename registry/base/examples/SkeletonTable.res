@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex w-full max-w-sm flex-col gap-2">
    {Array.fromInitializer(~length=5, index =>
      <div className="flex gap-4" key={Int.toString(index)}>
        <Skeleton className="h-4 flex-1" />
        <Skeleton className="h-4 w-24" />
        <Skeleton className="h-4 w-20" />
      </div>
    )->React.array}
  </div>
