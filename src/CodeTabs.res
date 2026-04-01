@@directive("'use client'")

@react.component
let make = (~children) => {
  let (installationType, setInstallationType) = Config.InstallationType.use()

  <Tabs
    value={installationType}
    onValueChange={(value, _) => setInstallationType(_ => value)}
    className="relative mt-6 w-full *:data-[slot=tabs-list]:gap-6"
  >
    {children}
  </Tabs>
}
