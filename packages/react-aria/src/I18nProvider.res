type props = {children?: React.element, locale?: string}

@module("react-aria-components")
external make: React.component<props> = "I18nProvider"

module Locale = {
  type t = {direction: string, locale: string}
}

@module("react-aria-components")
external useLocale: unit => Locale.t = "useLocale"
