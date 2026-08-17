@@directive("'use client'")

@react.component
let make = (~children) => {
  let (installationType, setInstallationType) = Config.InstallationType.use()

  <Tabs
    value={installationType->Config.InstallationType.toString}
    onValueChange={(value, _) =>
      setInstallationType(_ => value->Config.InstallationType.fromString)}
    className="relative mt-6 w-full *:data-[slot=tabs-list]:gap-6"
  >
    {children}
  </Tabs>
}
