@@directive("'use client'")

@react.component
let make = (~children) => {
  <ThemeProvider>
    <Sidebar.Provider>
      <Tooltip.Provider>
        <NavMenu />
        <Sidebar.Inset>
          <div className="flex flex-col self-center max-w-3xl px-4 py-8"> {children} </div>
        </Sidebar.Inset>
        <Sonner position=TopCenter />
      </Tooltip.Provider>
    </Sidebar.Provider>
  </ThemeProvider>
}

let default = make
