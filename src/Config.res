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
