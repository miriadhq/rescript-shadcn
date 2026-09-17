@@directive("'use client'")

@react.component
let make = (~children) => {
  let pathname = Next.Navigation.usePathname()

  let content =
    <ThemeProvider>
      <Sidebar.Provider>
        <Tooltip.Provider>
          <NavMenu />
          <Sidebar.Inset className="w-full min-w-0">
            <StyleSwitcher.BodyScope />
            {if pathname->String.startsWith("/components") {
              <>
                <div className="fixed right-4 top-4 z-30 hidden items-center gap-2 md:flex">
                  <LibSwitcher />
                  <StyleSwitcher />
                </div>
                <div className="fixed right-4 bottom-4 z-30 flex items-center gap-2 md:hidden">
                  <LibSwitcher side=BaseUi.Types.Side.Top />
                  <StyleSwitcher side=BaseUi.Types.Side.Top />
                </div>
              </>
            } else {
              React.null
            }}
            <div className="flex flex-col self-center max-w-3xl px-4 pb-8 pt-16 md:py-8 w-full">
              <Sidebar.Trigger
                className="md:hidden fixed left-4 bottom-4 z-20 rounded-md bg-stone-800 p-1"
              />
              {children}
            </div>
          </Sidebar.Inset>
          <Sonner position=TopCenter />
          <Toast.Toaster />
        </Tooltip.Provider>
      </Sidebar.Provider>
    </ThemeProvider>

  if pathname->String.startsWith("/og/render") {
    children
  } else {
    <React.Suspense fallback=React.null>
      {switch Config.LibStyle.fromPathname(pathname) {
      | Some(_) => content
      | None => <QuerySelection> content </QuerySelection>
      }}
    </React.Suspense>
  }
}

let default = make
