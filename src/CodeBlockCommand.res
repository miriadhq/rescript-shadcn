@@directive("'use client'")

module TablerIcons = {
  type props = {className?: string}

  module IconCheck = {
    @module("@tabler/icons-react")
    external make: React.component<props> = "IconCheck"
  }

  module IconCopy = {
    @module("@tabler/icons-react")
    external make: React.component<props> = "IconCopy"
  }

  module IconTerminal = {
    @module("@tabler/icons-react")
    external make: React.component<props> = "IconTerminal"
  }
}

@val @scope(("navigator", "clipboard"))
external writeText: string => promise<unit> = "writeText"

@react.component
let make = (~npm, ~yarn, ~pnpm, ~bun) => {
  let (config, setConfig) = Config.use()
  let (hasCopied, setHasCopied) = React.useState(() => false)

  React.useEffect(() => {
    if hasCopied {
      let timer = setTimeout(~handler=() => setHasCopied(_ => false), ~timeout=2000)
      Some(() => clearTimeout(timer))
    } else {
      None
    }
  }, [hasCopied])

  let tabs = React.useMemo(
    () => dict{"npm": npm, "yarn": yarn, "pnpm": pnpm, "bun": bun},
    [npm, yarn, pnpm, bun],
  )

  let copyCommand = React.useCallback(_ => {
    tabs
    ->Dict.get((config.packageManager :> string))
    ->Option.forEach(command => {
      writeText(command)->ignore
      setHasCopied(_ => true)
    })
  }, (config, tabs))

  <div className="overflow-x-auto">
    <Tabs
      value=config.packageManager
      className="gap-0"
      onValueChange={(value, _) => setConfig({...config, packageManager: value})}
    >
      <div className="flex items-center gap-2 border-b border-border/50 px-3 py-1">
        <div
          className="flex size-4 items-center justify-center rounded-[1px] bg-foreground opacity-70"
        >
          <TablerIcons.IconTerminal className="size-3 text-code" />
        </div>
        <Tabs.List className="rounded-none bg-transparent p-0">
          {tabs
          ->Dict.toArray
          ->Array.map(((key, _)) =>
            <Tabs.Trigger
              key
              value=key
              className="h-7 border border-transparent pt-0.5 shadow-none! data-active:border-input data-active:bg-background!"
            >
              {key->React.string}
            </Tabs.Trigger>
          )
          ->React.array}
        </Tabs.List>
      </div>
      <div className="no-scrollbar overflow-x-auto">
        {tabs
        ->Dict.toArray
        ->Array.map(((key, value)) =>
          <Tabs.Content key value=key className="mt-0 px-4 py-3.5">
            <pre>
              <code className="relative font-mono text-sm leading-none">
                {value->React.string}
              </code>
            </pre>
          </Tabs.Content>
        )
        ->React.array}
      </div>
    </Tabs>
    <Button
      dataSlot="copy-button"
      size=Button.Size.Icon
      variant=Button.Variant.Ghost
      className="absolute top-2 right-2 z-10 size-7 opacity-70 hover:opacity-100 focus-visible:opacity-100"
      onClick=copyCommand
    >
      <span className="sr-only"> {"Copy"->React.string} </span>
      {hasCopied ? <TablerIcons.IconCheck /> : <TablerIcons.IconCopy />}
    </Button>
  </div>
}
