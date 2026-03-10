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
      render={<div className="absolute top-1.5 right-9 z-10 flex items-center" />}
    >
      <Button variant=Ghost size=Sm className="text-muted-foreground h-7 rounded-md px-2">
        {(isOpened ? "Collapse" : "Expand")->React.string}
      </Button>
      <Separator orientation=Vertical className="mx-1.5 !h-4" />
    </Collapsible.Trigger>
    <Collapsible.Content
      className="relative mt-6 overflow-hidden data-[state=closed]:max-h-64 data-[state=closed]:[content-visibility:auto] [&>figure]:mt-0 [&>figure]:md:!mx-0"
    >
      {children}
    </Collapsible.Content>
    <Collapsible.Trigger
      className="from-code/70 to-code text-muted-foreground absolute inset-x-0 -bottom-2 flex h-20 items-center justify-center rounded-b-lg bg-gradient-to-b text-sm group-data-[state=open]/collapsible:hidden"
    >
      {(isOpened ? "Collapse" : "Expand")->React.string}
    </Collapsible.Trigger>
  </Collapsible>
}
