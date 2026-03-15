@unboxed
type packageManager =
  | @as("npm") Npm
  | @as("yarn") Yarn
  | @as("pnpm") Pnpm
  | @as("bun") Bun

@unboxed
type installationType =
  | @as("cli") Cli
  | @as("manual") Manual

type t = {
  packageManager: packageManager,
  installationType: installationType,
}

let configAtom = Jotai.Atom.withStorage(
  "config",
  {
    packageManager: Npm,
    installationType: Cli,
  },
)

let use = () => Jotai.Atom.use(configAtom)
