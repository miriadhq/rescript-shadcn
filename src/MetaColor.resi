module Result: {
  type t = {
    metaColor: string,
    setMetaColor: string => unit,
  }
}
let use: unit => Result.t
