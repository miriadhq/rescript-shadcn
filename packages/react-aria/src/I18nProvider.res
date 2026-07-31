type props = {children?: React.element, locale?: string}

@module("react-aria-components")
external make: React.component<props> = "I18nProvider"

type locale = {direction: string, locale: string}

@module("react-aria-components")
external useLocale: unit => locale = "useLocale"
