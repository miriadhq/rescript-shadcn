@@directive("'use client'")

@react.component
let make = (~children) => {
  let (config, setConfig) = Config.use()

  <Tabs
    value=config.installationType
    onValueChange={(value, _) => setConfig({...config, installationType: value})}
    className="relative mt-6 w-full *:data-[slot=tabs-list]:gap-6"
  >
    {children}
  </Tabs>
}
