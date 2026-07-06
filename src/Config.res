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

  let fromStringOpt = (value: string) =>
    switch (value :> CatchAll.t) {
    | ...t as style => style->Some
    | CatchAll.Other(_) => None
    }

  let fromString = (value: string) => value->fromStringOpt->Option.getOr(default)

  let styleParamName = "style"

  let getStyleParam = (searchParams: Next.Navigation.searchParams) =>
    searchParams->WebAPI.URLSearchParams.get(styleParamName)->Null.toOption

  let getCurrentStyleParam = () =>
    WebAPI.Global.window.location.search
    ->WebAPI.URLSearchParams.fromString
    ->getStyleParam
    ->Option.flatMap(fromStringOpt)

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
    let (style, setStoredStyle) = SignalsUtils.useWithLocalStorage(
      ~key=styleParamName,
      ~atom,
      ~valueFromString=fromString,
      ~valueToString=toString,
    )
    let pathname = Next.Navigation.usePathname()
    let setStyle = React.useCallback(update => {
      let nextStyle = update(Signal.get(atom))
      setStoredStyle(_ => nextStyle)
      if pathname->String.startsWith("/components") {
        replaceStyleParam(pathname, nextStyle)
      }
    }, (pathname, setStoredStyle))

    React.useEffect(() => {
      syncBodyStyleClass(style)
      if pathname->String.startsWith("/components") {
        switch getCurrentStyleParam() {
        | Some(queryStyle) if queryStyle->toString != style->toString =>
          setStoredStyle(_ => queryStyle)
        | None if style->toString == default->toString => ()
        | _ => replaceStyleParam(pathname, style)
        }
      }
      None
    }, (style, pathname, setStoredStyle))

    (style, setStyle)
  }
}
