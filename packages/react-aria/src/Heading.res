/** Direct binding for React Aria's Heading export. */
type props = {
  ...Common.ElementProps.t,
  level?: int,
}

@module("react-aria-components")
external make: React.component<props> = "Heading"
