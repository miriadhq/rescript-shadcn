module Colors = {
  type t = {
    light: string,
    dark: string,
  }
}

module Result = {
  type t = {
    metaColor: string,
    setMetaColor: string => unit,
  }
}

let default = {
  Colors.light: "#ffffff",
  dark: "#0a0a0a",
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
    WebAPI.Window.current
    ->WebAPI.Window.document
    ->WebAPI.Document.querySelector(`meta[name="theme-color"]`)
    ->Null.forEach(element =>
      element->WebAPI.Element.setAttribute(~qualifiedName="content", ~value=color)
    )
  }, [])

  {Result.metaColor, setMetaColor}
}
