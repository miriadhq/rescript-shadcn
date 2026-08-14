/** Direct binding for React Aria's Heading export. */
type props = {
  ...Common.elementProps,
  level?: int,
}

@module("react-aria-components")
external make: React.component<props> = "Heading"
