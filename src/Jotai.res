module Atom = {
  type t<'value>

  @module("jotai/utils")
  external withStorage: (string, 'value) => t<'value> = "atomWithStorage"

  @module("jotai")
  external use: t<'value> => ('value, 'value => unit) = "useAtom"
}
