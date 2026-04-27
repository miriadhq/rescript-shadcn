@@directive("'use client'")

@react.component
let make = () => {
  <>
    <header className="flex flex-col gap-4 mb-4">
      <div className="flex items-center gap-2">
        <BrandIcons.RescriptShadcn className="h-8 w-auto" />
        <h1 className="text-3xl font-bold tracking-tight"> {"Rescript-Shadcn"->React.string} </h1>
      </div>
      <p className="text-muted-foreground">
        {"Beautiful rescript-react components based on base-ui, distributed using shadcn."->React.string}
      </p>
    </header>

    <main className="flex flex-col flex-1 gap-8">
      <div className="flex flex-wrap gap-3 sm:self-start">
        <Button render={<Next.Link href="/installation" />} nativeButton=false>
          {"Get started"->React.string}
        </Button>
        <Button render={<Next.Link href="/components" />} nativeButton=false variant=Outline>
          {"See components"->React.string}
        </Button>
      </div>
      <HomeDemo />
    </main>
  </>
}

let default = make
