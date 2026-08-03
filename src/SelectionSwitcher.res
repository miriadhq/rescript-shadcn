@@directive("'use client'")

@react.component
let make = (~className=?, ~side=BaseUi.Types.Side.Bottom) => {
  <section
    className={Commons.cn(
      "flex flex-col gap-4 rounded-xl border bg-card p-4 sm:flex-row sm:items-center sm:justify-between sm:p-5",
      className,
    )}
  >
    <div className="space-y-1">
      <h2 className="font-medium"> {"Choose your setup"->React.string} </h2>
      <p className="text-sm text-muted-foreground">
        {"Pick a component library and visual style. You can change either later."->React.string}
      </p>
    </div>
    <div className="flex shrink-0 flex-wrap gap-2">
      <LibSwitcher side />
      <StyleSwitcher side />
    </div>
  </section>
}
