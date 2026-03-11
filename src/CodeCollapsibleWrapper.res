@@directive("'use client'")

@react.component
let make = (~className=?, ~children) => {
  let (isOpened, setIsOpened) = React.useState(() => false)

  <Collapsible
    open_=isOpened
    onOpenChange={(v, _) => setIsOpened(_ => v)}
    className={Commons.cn("group/collapsible relative md:-mx-1", className)}
  >
    <Collapsible.Trigger
      nativeButton=false
      render={<div className="absolute top-1.5 right-9 z-10 flex flex-row items-center" />}
    >
      <Button variant=Ghost size=Sm className="h-7 rounded-md px-2 text-muted-foreground">
        {(isOpened ? "Collapse" : "Expand")->React.string}
      </Button>
      <Separator orientation=Vertical className="mx-1.5 data-vertical:self-auto h-4" />
    </Collapsible.Trigger>
    <div
      className="relative mt-6 overflow-hidden group-data-closed/collapsible:max-h-64 group-data-closed/collapsible:[content-visibility:auto] [&>figure]:mt-0 [&>figure]:md:mx-0!"
    >
      {children}
    </div>
    <Collapsible.Trigger
      className="absolute inset-x-0 -bottom-2 flex h-20 items-center justify-center rounded-b-lg bg-linear-to-b from-code/70 to-code text-sm text-muted-foreground group-data-open/collapsible:hidden"
    >
      {(isOpened ? "Collapse" : "Expand")->React.string}
    </Collapsible.Trigger>
  </Collapsible>
}
