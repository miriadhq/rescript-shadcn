module Metadata = {
  type t = {
    title: string,
    description: string,
  }
}

@val @scope(("process", "env"))
external publicBaseUrl: string = "NEXT_PUBLIC_BASE_URL"

module Font = {
  module Options = {
    type t = {
      subsets?: array<string>,
      variable?: string,
    }
  }
  type t = private {
    variable: string,
  }
}

module Layout = {
  module Props = {
    type t = {
      children: React.element,
    }
  }
}

module Navigation = {
  @module("next/navigation") external usePathname: unit => string = "usePathname"
}

module Link = {
  @module("next/link") @react.component
  external make: (
    ~href: string,
    ~className: string=?,
    ~children: React.element=?,
    ~target: string=?,
    ~rel: string=?,
  ) => React.element = "default"
}

module Image = {
  @module("next/image") @react.component
  external make: (
    ~src: string,
    ~alt: string,
    ~width: int=?,
    ~height: int=?,
    ~className: string=?,
    ~children: React.element=?,
  ) => React.element = "default"
}

module Fetch = {
  type nextOptions = {
    revalidate: int,
  }
  type requestInit = {
    next: nextOptions,
  }
}

external fetch: (string, ~init: Fetch.requestInit=?) => promise<WebAPI.FetchAPI.response> = "fetch"

module Themes = {
  @unboxed
  type t =
    | @as("light") Light
    | @as("dark") Dark

  type hookResult = {
    setTheme: t => unit,
    resolvedTheme: t,
  }
  @module("next-themes") external use: unit => hookResult = "useTheme"

  module Provider = {
    @module("next-themes") @react.component
    external make: (
      ~attribute: string=?,
      ~defaultTheme: string=?,
      ~enableSystem: bool=?,
      ~disableTransitionOnChange: bool=?,
      ~enableColorScheme: bool=?,
      ~children: React.element,
    ) => React.element = "ThemeProvider"
  }
}

module Script = {
  @module("next/script") @react.component
  external make: (
    ~id: string,
    ~strategy: string=?,
    ~dangerouslySetInnerHTML: dict<string>=?,
  ) => React.element = "default"
}
