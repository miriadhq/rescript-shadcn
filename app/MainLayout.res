@@directive("'use client'")

@react.component
let make = (~children) => {
  <ThemeProvider>
    <Sidebar.Provider>
      <Tooltip.Provider>
        <NavMenu />
        <Sidebar.Inset className="w-full min-w-0">
          <div className="flex flex-col self-center max-w-3xl px-4 py-8 w-full"> {children} </div>
        </Sidebar.Inset>
        <Sonner position=TopCenter />
      </Tooltip.Provider>
    </Sidebar.Provider>
  </ThemeProvider>
}

let default = make
