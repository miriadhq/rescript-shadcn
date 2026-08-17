module Filter = {
  type t = (string, string) => bool
}

type props = {
  ...Common.ElementProps.t,
  filter?: Filter.t,
  inputValue?: string,
  defaultInputValue?: string,
  onInputChange?: string => unit,
}

@module("react-aria-components")
external make: React.component<props> = "Autocomplete"

module FilterOptions = {
  type t = {sensitivity: string}
}

module FilterResult = {
  type t = {
    contains: Filter.t,
    startsWith: Filter.t,
    endsWith: Filter.t,
  }
}

@module("react-aria-components")
external useFilter: FilterOptions.t => FilterResult.t = "useFilter"
