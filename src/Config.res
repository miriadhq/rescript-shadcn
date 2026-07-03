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

module Style = {
  open Signals

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

  type option = {
    label: string,
    value: t,
  }

  external fromString: string => t = "%identity"
  external toString: t => string = "%identity"

  let options = [
    {label: "Vega", value: Vega},
    {label: "Nova", value: Nova},
    {label: "Lyra", value: Lyra},
    {label: "Maia", value: Maia},
    {label: "Mira", value: Mira},
    {label: "Luma", value: Luma},
    {label: "Sera", value: Sera},
    {label: "Rhea", value: Rhea},
  ]

  let atom = Signal.make(Nova)

  let normalize = styleName =>
    styleName
    ->Option.map(name =>
      name
      ->String.replace("base-", "")
      ->String.replace("radix-", "")
      ->String.replace("style-", "")
      ->fromString
    )
    ->Option.getOr(Nova)

  let use = () =>
    SignalsUtils.useWithLocalStorage(
      ~key="style",
      ~atom,
      ~valueFromString=fromString,
      ~valueToString=toString,
    )
}
