module Params = {
  type t<'state> = {
    render?: React.element,
    props?: Types.BaseUIComponentProps.t,
    state?: 'state,
    defaultTagName?: string,
    enabled?: bool,
  }
}

@module("@base-ui/react/use-render")
external use: Params.t<'state> => React.element = "useRender"
