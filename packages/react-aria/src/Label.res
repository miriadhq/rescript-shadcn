type props = {...Common.elementProps, htmlFor?: string}

@module("react-aria-components")
external context: React.Context.t<nullable<JSON.t>> = "LabelContext"

@module("react-aria-components")
external make: React.component<props> = "Label"
