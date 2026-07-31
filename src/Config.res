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

module Lib = {
  @unboxed
  type t =
    | @as("base") Base
    | @as("aria") Aria

  let default = Base

  module CatchAll = {
    @unboxed
    type t =
      | ...t
      | Other(string)
  }

  let toString = (value: t) => (value :> string)
  let all = [Base, Aria]
  let atom = Signals.Signal.make(default)

  let fromStringOpt = (value: string) =>
    switch (value :> CatchAll.t) {
    | ...t as lib => Some(lib)
    | CatchAll.Other(_) => None
    }

  let fromString = value => value->fromStringOpt->Option.getOr(default)
}

module Style = {
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

  let atom = Signals.Signal.make(default)

  let fromStringOpt = (value: string) =>
    switch (value :> CatchAll.t) {
    | ...t as style => style->Some
    | CatchAll.Other(_) => None
    }

  let fromString = (value: string) => value->fromStringOpt->Option.getOr(default)

}

module Selection = {
  open Signals

  type t = {
    lib: Lib.t,
    style: Style.t,
  }

  let default = {lib: Lib.default, style: Style.default}
  let paramName = "style"
  let libStorageKey = "lib"

  let toString = selection =>
    `${selection.lib->Lib.toString}-${selection.style->Style.toString}`

  let fromStringOpt = value => {
    let parts = value->String.split("-")
    switch (parts->Array.get(0), parts->Array.get(1)) {
    | (Some(lib), Some(style)) =>
      switch (lib->Lib.fromStringOpt, style->Style.fromStringOpt) {
      | (Some(lib), Some(style)) => Some({lib, style})
      | _ => None
      }
    | (Some(style), None) => style->Style.fromStringOpt->Option.map(style => {lib: Lib.Base, style})
    | _ => None
    }
  }

  let fromString = value => value->fromStringOpt->Option.getOr(default)

  let getParam = (searchParams: Next.Navigation.searchParams) =>
    searchParams->WebAPI.URLSearchParams.get(paramName)->Null.toOption

  let getCurrentParam = () =>
    WebAPI.Global.window.location.search
    ->WebAPI.URLSearchParams.fromString
    ->getParam
    ->Option.flatMap(fromStringOpt)

  let hrefFor = (pathname, selection) => {
    let location = WebAPI.Global.window.location
    let params = WebAPI.URLSearchParams.fromString(location.search)
    params->WebAPI.URLSearchParams.set(~name=paramName, ~value=toString(selection))

    let query = params->WebAPI.URLSearchParams.toString
    switch query {
    | "" => `${pathname}${location.hash}`
    | query => `${pathname}?${query}${location.hash}`
    }
  }

  let syncBodyClasses = selection => {
    let classList = WebAPI.Global.document.body.classList
    Style.all->Array.forEach(style =>
      classList->WebAPI.DOMTokenList.remove(`style-${style->Style.toString}`)
    )
    Lib.all->Array.forEach(lib =>
      classList->WebAPI.DOMTokenList.remove(`lib-${lib->Lib.toString}`)
    )
    classList->WebAPI.DOMTokenList.add(`style-${selection.style->Style.toString}`)
    classList->WebAPI.DOMTokenList.add(`lib-${selection.lib->Lib.toString}`)
  }

  let use = () => {
    let (lib, setStoredLib) = SignalsUtils.useWithLocalStorage(
      ~key=libStorageKey,
      ~atom=Lib.atom,
      ~valueFromString=Lib.fromString,
      ~valueToString=Lib.toString,
    )
    let (style, setStoredStyle) = SignalsUtils.useWithLocalStorage(
      ~key=paramName,
      ~atom=Style.atom,
      ~valueFromString=Style.fromString,
      ~valueToString=Style.toString,
    )
    let pathname = Next.Navigation.usePathname()
    let searchParams = Next.Navigation.useSearchParams()
    let router = Next.Navigation.useRouter()
    let storedSelection = {lib, style}
    let querySelection = searchParams->getParam->Option.flatMap(fromStringOpt)
    let selection = querySelection->Option.getOr(storedSelection)

    let navigate = nextSelection =>
      if pathname->String.startsWith("/components") {
        router->Next.Navigation.replace(hrefFor(pathname, nextSelection))
      }

    let setLib = React.useCallback(update => {
      let nextLib = update(Signal.get(Lib.atom))
      setStoredLib(_ => nextLib)
      navigate({lib: nextLib, style: selection.style})
    }, (pathname, router, setStoredLib, selection.style))

    let setStyle = React.useCallback(update => {
      let nextStyle = update(Signal.get(Style.atom))
      setStoredStyle(_ => nextStyle)
      navigate({lib: selection.lib, style: nextStyle})
    }, (pathname, router, setStoredStyle, selection.lib))

    React.useEffect(() => {
      syncBodyClasses(selection)
      if pathname->String.startsWith("/components") {
        switch querySelection {
        | Some(querySelection) if querySelection->toString != storedSelection->toString => {
            setStoredLib(_ => querySelection.lib)
            setStoredStyle(_ => querySelection.style)
          }
        | None => navigate(storedSelection)
        | _ => ()
        }
      }
      None
    }, (lib, style, selection.lib, selection.style, pathname, router, setStoredLib, setStoredStyle))

    (selection, setLib, setStyle)
  }
}
