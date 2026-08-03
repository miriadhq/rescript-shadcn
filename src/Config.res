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

module LibStyle = {
  open Signals

  type t = {
    lib: Lib.t,
    style: Style.t,
  }

  let default = {lib: Lib.default, style: Style.default}
  let paramName = "style"
  let libStorageKey = "lib"

  let toString = libStyle =>
    `${libStyle.lib->Lib.toString}-${libStyle.style->Style.toString}`

  let interpolate = (template, libStyle) =>
    template->String.replaceAll("{{libStyle}}", libStyle->toString)

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

  let hrefFor = (pathname, libStyle) => {
    let location = WebAPI.Global.window.location
    let params = WebAPI.URLSearchParams.fromString(location.search)
    params->WebAPI.URLSearchParams.set(~name=paramName, ~value=toString(libStyle))

    let query = params->WebAPI.URLSearchParams.toString
    switch query {
    | "" => `${pathname}${location.hash}`
    | query => `${pathname}?${query}${location.hash}`
    }
  }

  let syncBodyClasses = libStyle => {
    let classList = WebAPI.Global.document.body.classList
    Style.all->Array.forEach(style =>
      classList->WebAPI.DOMTokenList.remove(`style-${style->Style.toString}`)
    )
    Lib.all->Array.forEach(lib =>
      classList->WebAPI.DOMTokenList.remove(`lib-${lib->Lib.toString}`)
    )
    classList->WebAPI.DOMTokenList.add(`style-${libStyle.style->Style.toString}`)
    classList->WebAPI.DOMTokenList.add(`lib-${libStyle.lib->Lib.toString}`)
  }

  let use = () => {
    let (lib, setStoredLib, libHydrated) = SignalsUtils.useWithLocalStorageHydrated(
      ~key=libStorageKey,
      ~atom=Lib.atom,
      ~valueFromString=Lib.fromString,
      ~valueToString=Lib.toString,
    )
    let (style, setStoredStyle, styleHydrated) = SignalsUtils.useWithLocalStorageHydrated(
      ~key=paramName,
      ~atom=Style.atom,
      ~valueFromString=Style.fromString,
      ~valueToString=Style.toString,
    )
    let pathname = Next.Navigation.usePathname()
    let searchParams = Next.Navigation.useSearchParams()
    let router = Next.Navigation.useRouter()
    let storedLibStyle = {lib, style}
    let queryLibStyle = searchParams->getParam->Option.flatMap(fromStringOpt)
    let libStyle = queryLibStyle->Option.getOr(storedLibStyle)
    let syncsLibStyle =
      pathname === "/" ||
      pathname === "/installation" ||
      pathname->String.startsWith("/components")

    let navigate = nextLibStyle =>
      if syncsLibStyle && libHydrated && styleHydrated {
        router->Next.Navigation.replace(hrefFor(pathname, nextLibStyle))
      }

    let setLib = React.useCallback(update => {
      let nextLib = update(Signal.get(Lib.atom))
      setStoredLib(_ => nextLib)
      navigate({lib: nextLib, style: libStyle.style})
    }, (pathname, router, setStoredLib, libStyle.style, libHydrated, styleHydrated))

    let setStyle = React.useCallback(update => {
      let nextStyle = update(Signal.get(Style.atom))
      setStoredStyle(_ => nextStyle)
      navigate({lib: libStyle.lib, style: nextStyle})
    }, (pathname, router, setStoredStyle, libStyle.lib, libHydrated, styleHydrated))

    React.useEffect(() => {
      syncBodyClasses(libStyle)
      if syncsLibStyle && libHydrated && styleHydrated {
        switch queryLibStyle {
        | Some(queryLibStyle) if queryLibStyle->toString != storedLibStyle->toString => {
            setStoredLib(_ => queryLibStyle.lib)
            setStoredStyle(_ => queryLibStyle.style)
          }
        | None => navigate(storedLibStyle)
        | _ => ()
        }
      }
      None
    }, (
      lib,
      style,
      libStyle.lib,
      libStyle.style,
      libHydrated,
      styleHydrated,
      pathname,
      router,
      setStoredLib,
      setStoredStyle,
    ))

    (libStyle, setLib, setStyle)
  }
}
