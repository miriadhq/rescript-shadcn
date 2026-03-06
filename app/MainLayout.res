@@directive("'use client'")

@react.component
let make = (~children) => {
  <Sidebar.Provider>
    <NavMenu />
    <Sidebar.Inset> {children} </Sidebar.Inset>
  </Sidebar.Provider>
}

let default = make
