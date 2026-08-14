type filter = (string, string) => bool

type props = {
  ...Common.elementProps,
  filter?: filter,
  inputValue?: string,
  defaultInputValue?: string,
  onInputChange?: string => unit,
}

@module("react-aria-components")
external make: React.component<props> = "Autocomplete"

type filterOptions = {sensitivity: string}
type filterResult = {
  contains: filter,
  startsWith: filter,
  endsWith: filter,
}

@module("react-aria-components")
external useFilter: filterOptions => filterResult = "useFilter"
