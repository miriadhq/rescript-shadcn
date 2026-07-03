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
              <StyleSwitcher.BodyScope />
              {if pathname->String.startsWith("/components") {
                <>
                  <StyleSwitcher className="fixed right-4 top-4 z-30 hidden md:block" />
                  <StyleSwitcher
                    className="fixed right-4 bottom-4 z-30 md:hidden"
                    side=BaseUi.Types.Side.Top
                  />
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
          </Tooltip.Provider>
        </Sidebar.Provider>
      </ThemeProvider>
}

let default = make
