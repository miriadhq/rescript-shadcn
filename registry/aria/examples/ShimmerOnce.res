@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (key, setKey) = React.useState(() => 0)
  <div className="flex flex-col items-center gap-4">
    <p
      key={key->Int.toString}
      className="shimmer text-sm text-muted-foreground shimmer-duration-1100 shimmer-once"
    >
      {"Generating response…"->React.string}
    </p>
    <Button variant=Outline size=Sm onClick={_ => setKey(value => value + 1)}>
      {"Replay"->React.string}
    </Button>
  </div>
}
