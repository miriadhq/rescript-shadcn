@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div
    className="mx-auto grid w-full max-w-lg gap-6 text-center text-sm text-muted-foreground sm:grid-cols-2"
  >
    <div className="flex flex-col gap-3">
      <p className="shimmer"> {"Generating response…"->React.string} </p>
      <p className="font-mono text-xs"> {"shimmer"->React.string} </p>
    </div>
    <div className="flex flex-col gap-3">
      <p className="shimmer shimmer-angle-45"> {"Generating response…"->React.string} </p>
      <p className="font-mono text-xs"> {"shimmer-angle-45"->React.string} </p>
    </div>
  </div>
