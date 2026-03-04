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

module Link = {
  type props = {
    href: string,
    className?: string,
    children?: React.element,
  }

  @module("next/link")
  external make: React.component<props> = "default"
}
