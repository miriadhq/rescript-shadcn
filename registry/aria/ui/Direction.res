@@directive("'use client'")

module Provider = ReactAria.I18nProvider

let use = () => ReactAria.I18nProvider.useLocale().direction
