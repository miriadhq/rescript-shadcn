@@directive("'use client'")

module I18nProvider = ReactAria.I18nProvider

module Direction = {
  @unboxed
  type t =
    | @as("ltr") Ltr
    | @as("rtl") Rtl
}

type localeOptions = {script: string}

@new @scope("Intl")
external makeLocale: (string, localeOptions) => JSON.t = "Locale"

@send external localeToString: JSON.t => string = "toString"

type props = {direction?: Direction.t, ...ReactAria.I18nProvider.props}
let providerProps: props => ReactAria.I18nProvider.props = %raw(`props => props`)

@react.componentWithProps(props)
let make = (props: props) => {
  let currentLocale = ReactAria.I18nProvider.useLocale().locale
  let locale = switch (props.locale, props.direction) {
  | (Some(locale), _) => Some(locale)
  | (None, Some(direction)) =>
    Some(
      makeLocale(
        currentLocale,
        {script: switch direction {
        | Direction.Rtl => "Arab"
        | Ltr => "Latn"
        }},
      )->localeToString,
    )
  | (None, None) => None
  }
  <ReactAria.I18nProvider {...props->providerProps} ?locale />
}

let useDirection = () => ReactAria.I18nProvider.useLocale().direction
let useLocale = ReactAria.I18nProvider.useLocale
