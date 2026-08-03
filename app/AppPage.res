@@directive("'use client'")

@react.component
let make = () => {
  let (libStyle, _, _) = Config.LibStyle.use()
  let libStyleParam = libStyle->Config.LibStyle.toString

  <>
    <header className="flex flex-col gap-4 mb-4">
      <div className="flex items-center gap-2">
        <BrandIcons.RescriptShadcn className="h-8 w-auto" />
        <h1 className="text-3xl font-bold tracking-tight"> {"Rescript-Shadcn"->React.string} </h1>
      </div>
      <p className="text-muted-foreground">
        {"Beautiful ReScript React components built on Base UI or React Aria, distributed using shadcn."->React.string}
      </p>
    </header>

    <main className="flex flex-col flex-1 gap-8">
      <SelectionSwitcher />
      <div className="flex flex-wrap gap-3 sm:self-start">
        <Button
          render={<Next.Link href={`/installation?style=${libStyleParam}`} />} nativeButton=false
        >
          {"Get started"->React.string}
        </Button>
        <Button
          render={<Next.Link href={`/components?style=${libStyleParam}`} />}
          nativeButton=false
          variant=Outline
        >
          {"See components"->React.string}
        </Button>
      </div>
      <HomeDemo />
    </main>
  </>
}

let default = make
