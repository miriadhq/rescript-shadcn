type params<'state> = {
  render?: React.element,
  props?: Types.DomProps.t,
  state?: 'state,
  defaultTagName?: string,
  enabled?: bool,
}

@module("@base-ui/react/merge-props")
external mergeProps: (BaseUi.Types.DomProps.t, BaseUi.Types.DomProps.t) => BaseUi.Types.DomProps.t =
  "mergeProps"

@module("@base-ui/react/use-render")
external use: params<'state> => React.element = "useRender"
