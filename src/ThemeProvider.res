@react.component
let make = (~children) => {
  <Next.Themes.Provider
    attribute="class"
    defaultTheme="system"
    enableSystem=true
    disableTransitionOnChange=true
    enableColorScheme=true
  >
    {children}
  </Next.Themes.Provider>
}
