@@directive("'use client'")

let context: React.Context.t<option<string>> = React.createContext(None)

module Provider = {
  let make = React.Context.provider(context)
}

let use = () => React.useContext(context)

@react.component
let make = (~children) => {
  let searchParams = Next.Navigation.useSearchParams()
  let value = searchParams->WebAPI.URLSearchParams.get("style")->Null.toOption
  <Provider value> children </Provider>
}
