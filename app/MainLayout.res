@@directive("'use client'")

@react.component
let make = (~children) => {
  let pathname = Next.Navigation.usePathname()

  pathname->String.startsWith("/og/render")
    ? children
    : <ThemeProvider>
        <Sidebar.Provider>
          <Tooltip.Provider>
            <NavMenu />
            <Sidebar.Inset className="w-full min-w-0">
              <div className="flex flex-col self-center max-w-3xl px-4 py-8 w-full">
                <Sidebar.Trigger
                  className="md:hidden fixed bottom-4 p-1 rounded-md bg-stone-800 z-10"
                />
                {children}
              </div>
            </Sidebar.Inset>
            <Sonner position=TopCenter />
          </Tooltip.Provider>
        </Sidebar.Provider>
      </ThemeProvider>
}

let default = make
