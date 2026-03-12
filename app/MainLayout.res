@@directive("'use client'")

@react.component
let make = (~children) => {
  <ThemeProvider>
    <Sidebar.Provider>
      <Tooltip.Provider>
        <NavMenu />
        <Sidebar.Inset> {children} </Sidebar.Inset>
        <Sonner position=TopCenter />
      </Tooltip.Provider>
    </Sidebar.Provider>
  </ThemeProvider>
}

let default = make
