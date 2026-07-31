type params<'state> = {
  render?: React.element,
  props?: ReactAria.Types.BaseUIComponentProps.t,
  state?: 'state,
  defaultTagName?: string,
  enabled?: bool,
}

@module("react")
external createElement: (string, ReactAria.Types.BaseUIComponentProps.t) => React.element = "createElement"

@module("react")
external cloneElement: (
  React.element,
  ReactAria.Types.BaseUIComponentProps.t,
) => React.element = "cloneElement"

let use = (params: params<'state>) => {
  let props = params.props->Option.getOr({})
  switch params.render {
  | Some(element) => cloneElement(element, props)
  | None => createElement(params.defaultTagName->Option.getOr("div"), props)
  }
}
