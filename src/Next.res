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
