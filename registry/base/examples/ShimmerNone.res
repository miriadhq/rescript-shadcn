@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex flex-col items-center gap-3 text-sm text-muted-foreground">
    <p className="shimmer md:shimmer-none"> {"Generating response…"->React.string} </p>
    <p className="font-mono text-xs"> {"shimmer md:shimmer-none"->React.string} </p>
  </div>
