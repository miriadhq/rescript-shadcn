@@directive("'use client'")

type installationType =
  | Cli
  | Manual

@react.component
let make = (~children) => {
  let (installationType, setInstallationType) = React.useState(() => Cli)

  <Tabs
    value={installationType}
    onValueChange={(value, _) => setInstallationType(_ => value)}
    className="relative mt-6 w-full *:data-[slot=tabs-list]:gap-6"
  >
    {children}
  </Tabs>
}
