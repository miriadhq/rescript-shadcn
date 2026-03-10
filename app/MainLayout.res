@@directive("'use client'")

@react.component
let make = (~children) => {
  <Sidebar.Provider>
    <Tooltip.Provider>
      <NavMenu />
      <Sidebar.Inset> {children} </Sidebar.Inset>
      <Sonner position=TopCenter />
    </Tooltip.Provider>
  </Sidebar.Provider>
}

let default = make
