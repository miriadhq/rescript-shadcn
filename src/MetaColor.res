type t = {
  light: string,
  dark: string,
}

let default = {
  light: "#ffffff",
  dark: "#0a0a0a",
}

type hook = {
  metaColor: string,
  setMetaColor: string => unit,
}

let use = () => {
  let {resolvedTheme} = Next.Themes.use()

  let metaColor = React.useMemo(() => {
    switch resolvedTheme {
    | Dark => default.dark
    | Light => default.light
    }
  }, [resolvedTheme])

  let setMetaColor = React.useCallback(color => {
    document
    ->WebAPI.Document.querySelector(`meta[name="theme-color"]`)
    ->Null.forEach(element =>
      element->WebAPI.Element.setAttribute(~qualifiedName="content", ~value=color)
    )
  }, [])

  {metaColor, setMetaColor}
}
