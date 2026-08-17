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
  module SearchParams = {
    type t = WebAPI.URLSearchParams.t
  }

  module Router = {
    type t
  }

  @module("next/navigation") external usePathname: unit => string = "usePathname"
  @module("next/navigation") external useSearchParams: unit => SearchParams.t = "useSearchParams"
  @module("next/navigation") external useRouter: unit => Router.t = "useRouter"
  @send external replace: (Router.t, string) => unit = "replace"
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
  module NextOptions = {
    type t = {
      revalidate: int,
    }
  }

  module RequestInit = {
    type t = {
      next: NextOptions.t,
    }
  }
}

external fetch: (string, ~init: Fetch.RequestInit.t=?) => promise<WebAPI.Response.t> = "fetch"

module Themes = {
  @unboxed
  type t =
    | @as("light") Light
    | @as("dark") Dark

  module HookResult = {
    type t = {
      setTheme: t => unit,
      resolvedTheme: t,
    }
  }
  @module("next-themes") external use: unit => HookResult.t = "useTheme"

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
