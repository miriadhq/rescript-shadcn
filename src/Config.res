module PackageManager = {
  open Signals

  @unboxed
  type t =
    | @as("npm") Npm
    | @as("yarn") Yarn
    | @as("pnpm") Pnpm
    | @as("bun") Bun

  external fromString: string => t = "%identity"
  external toString: t => string = "%identity"

  let atom = Signal.make(Npm)

  let use = () =>
    SignalsUtils.useWithLocalStorage(
      ~key="packageManager",
      ~atom,
      ~valueFromString=fromString,
      ~valueToString=toString,
    )
}

module InstallationType = {
  open Signals

  @unboxed
  type t =
    | @as("cli") Cli
    | @as("manual") Manual

  external fromString: string => t = "%identity"
  external toString: t => string = "%identity"

  let atom = Signal.make(Cli)

  let use = () =>
    SignalsUtils.useWithLocalStorage(
      ~key="installationType",
      ~atom,
      ~valueFromString=fromString,
      ~valueToString=toString,
    )
}

module Style = {
  open Signals

  @unboxed
  type t =
    | @as("vega") Vega
    | @as("nova") Nova
    | @as("lyra") Lyra
    | @as("maia") Maia
    | @as("mira") Mira
    | @as("luma") Luma
    | @as("sera") Sera
    | @as("rhea") Rhea

  let default = Vega

  module CatchAll = {
    @unboxed
    type t =
      | ...t
      | Other(string)
  }

  let toString = (t: t) => (t :> string)

  let all = [Vega, Nova, Lyra, Maia, Mira, Luma, Sera, Rhea]

  let atom = Signal.make(default)

  let fromString = (value: string) =>
    switch (value :> CatchAll.t) {
    | ...t as style => style
    | CatchAll.Other(_) => default
    }

  let styleParamName = "style"

  let getStyleParam = (searchParams: Next.Navigation.searchParams) =>
    searchParams->WebAPI.URLSearchParams.get(styleParamName)->Null.toOption

  let replaceStyleParam = (pathname, style) => {
    let location = WebAPI.Global.window.location
    let params = WebAPI.URLSearchParams.fromString(location.search)
    params->WebAPI.URLSearchParams.set(~name=styleParamName, ~value=toString(style))

    let query = params->WebAPI.URLSearchParams.toString
    let href = switch query {
    | "" => `${pathname}${location.hash}`
    | query => `${pathname}?${query}${location.hash}`
    }

    WebAPI.Global.history->WebAPI.History.replaceState(~data=JSON.Null, ~unused="", ~url=href)
  }

  let syncBodyStyleClass = style => {
    let classList = WebAPI.Global.document.body.classList
    all->Array.forEach(style => classList->WebAPI.DOMTokenList.remove(`style-${toString(style)}`))
    classList->WebAPI.DOMTokenList.add(`style-${toString(style)}`)
  }

  let use = () => {
    let (style, setStyle) = SignalsUtils.useWithLocalStorage(
      ~key=styleParamName,
      ~atom,
      ~valueFromString=fromString,
      ~valueToString=toString,
    )
    let pathname = Next.Navigation.usePathname()
    let searchParams = Next.Navigation.useSearchParams()

    React.useEffect(() => {
      syncBodyStyleClass(style)
      if pathname->String.startsWith("/components") {
        replaceStyleParam(pathname, style)
      }
      None
    }, (style, pathname))

    React.useEffect(() => {
      searchParams
      ->getStyleParam
      ->Option.forEach(queryStyle => setStyle(_ => queryStyle->fromString))
      None
    }, (searchParams, setStyle))

    (style, setStyle)
  }
}
