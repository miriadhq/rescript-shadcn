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
let make = (~npm: string, ~yarn: string, ~pnpm: string, ~bun: string) => {
  let (packageManager, setPackageManager) = React.useState(() => "pnpm")
  let (hasCopied, setHasCopied) = React.useState(() => false)

  React.useEffect(() => {
    if hasCopied {
      let timer = setTimeout(() => setHasCopied(_ => false), 2000)
      Some(() => clearTimeout(timer))
    } else {
      None
    }
  }, [hasCopied])

  let tabs = [("pnpm", pnpm), ("npm", npm), ("yarn", yarn), ("bun", bun)]

  let currentCommand =
    tabs
    ->Array.find(((key, _)) => key === packageManager)
    ->Option.map(((_, v)) => v)
    ->Option.getOr(pnpm)

  let copyCommand = _ => {
    writeText(currentCommand)->ignore
    setHasCopied(_ => true)
  }

  <div className="overflow-x-auto">
    <Tabs value=packageManager className="gap-0" onValueChange={(value, _) => setPackageManager(_ => value)}>
      <div className="flex items-center gap-2 border-b border-border/50 px-3 py-1">
        <div
          className="flex size-4 items-center justify-center rounded-[1px] bg-foreground opacity-70"
        >
          <TablerIcons.IconTerminal className="size-3 text-code" />
        </div>
        <Tabs.List className="rounded-none bg-transparent p-0">
          {tabs
          ->Array.map(((key, _)) =>
            <Tabs.Trigger
              key
              value=key
              className="h-7 border border-transparent pt-0.5 shadow-none! data-[state=active]:border-input data-[state=active]:bg-background!"
            >
              {key->React.string}
            </Tabs.Trigger>
          )
          ->React.array}
        </Tabs.List>
      </div>
      <div className="no-scrollbar overflow-x-auto">
        {tabs
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
