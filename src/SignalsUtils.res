// Keep first paint identical to SSR (default signal value), then hydrate from localStorage
// in an effect so React does not warn about server/client HTML mismatch.
let useWithLocalStorage = (~key, ~atom, ~valueFromString, ~valueToString) => {
  open Signals

  let (value, setValue) = React.useState(() => Signal.get(atom))

  React.useEffect(() => {
    switch globalThis["localStorage"] {
    | Some(localStorage) =>
      switch localStorage->WebAPI.Storage.getItem(key) {
      | Value(raw) =>
        Signal.set(atom, valueFromString(raw))
        setValue(_ => Signal.get(atom))
      | _ => ()
      }
      let disposer = Effect.run(() => {
        let v = Signal.get(atom)
        localStorage->WebAPI.Storage.setItem(~key, ~value=valueToString(v))
        setValue(_ => Signal.get(atom))
        None
      })
      Some(() => disposer.dispose())
    | None => None
    }
  }, (key, atom))

  let updater = React.useCallback(u => Signal.update(atom, u), [atom])

  (value, updater)
}
