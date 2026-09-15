@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex flex-col items-center gap-2 text-sm text-muted-foreground">
    <p className="shimmer shimmer-color-blue-500/60"> {"Generating response…"->React.string} </p>
    <p className="shimmer shimmer-color-[#378ADD]"> {"Generating response…"->React.string} </p>
  </div>
