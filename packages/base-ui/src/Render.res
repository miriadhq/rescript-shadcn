type params<'state> = {
  render?: React.element,
  props?: Types.BaseUIComponentProps.t,
  state?: 'state,
  defaultTagName?: string,
  enabled?: bool,
}

@module("@base-ui/react/use-render")
external use: params<'state> => React.element = "useRender"
