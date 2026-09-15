type toastObject = {
  id: string,
  title?: string,
  @as("type") type_?: string,
  description?: string,
}

@unboxed
type priority =
  | @as("low") Low
  | @as("high") High

type actionProps = {
  children?: React.element,
  onClick?: unit => unit,
}

type updateOptions = {
  title?: string,
  @as("type") type_?: string,
  description?: string,
  timeout?: int,
  priority?: priority,
  actionProps?: actionProps,
}

type addOptions = {
  ...updateOptions,
  id?: string,
}

type manager = {
  add: addOptions => string,
  close: option<string> => unit,
  update: (string, updateOptions) => unit,
}

type managerState = {
  toasts: array<toastObject>,
  add: addOptions => string,
  close: option<string> => unit,
  update: (string, updateOptions) => unit,
}

@send
external updateWith: (manager, string, toastObject => updateOptions) => unit = "update"

@send
external updateStateWith: (managerState, string, toastObject => updateOptions) => unit = "update"

@unboxed
type promiseMessage<'value> =
  | Text(string)
  | Resolve('value => string)

type promiseOptions<'value> = {
  loading: string,
  success: promiseMessage<'value>,
  error: string,
}

@send
external promise: (manager, promise<'value>, promiseOptions<'value>) => promise<'value> = "promise"

@module("@base-ui/react/toast") @scope("Toast")
external createToastManager: unit => manager = "createToastManager"

@module("@base-ui/react/toast") @scope("Toast")
external useToastManager: unit => managerState = "useToastManager"

module Root = {
  type props = {
    ...Types.BaseUIComponentProps.t,
    toast?: toastObject,
  }
  @module("@base-ui/react/toast") @scope("Toast")
  external make: React.component<props> = "Root"
}

module Provider = {
  type props = {
    ...Types.BaseUIComponentProps.t,
    timeout?: int,
    limit?: int,
    toastManager?: manager,
  }
  @module("@base-ui/react/toast") @scope("Toast")
  external make: React.component<props> = "Provider"
}

module Viewport = {
  @module("@base-ui/react/toast") @scope("Toast")
  external make: React.component<Types.BaseUIComponentProps.t> = "Viewport"
}

module Content = {
  @module("@base-ui/react/toast") @scope("Toast")
  external make: React.component<Types.BaseUIComponentProps.t> = "Content"
}

module Description = {
  @module("@base-ui/react/toast") @scope("Toast")
  external make: React.component<Types.BaseUIComponentProps.t> = "Description"
}

module Title = {
  @module("@base-ui/react/toast") @scope("Toast")
  external make: React.component<Types.BaseUIComponentProps.t> = "Title"
}

module Close = {
  type props = {...Types.BaseUIComponentProps.t, ...Types.NativeButtonProps.t}
  @module("@base-ui/react/toast") @scope("Toast")
  external make: React.component<props> = "Close"
}

module Action = {
  type props = {...Types.BaseUIComponentProps.t, ...Types.NativeButtonProps.t}
  @module("@base-ui/react/toast") @scope("Toast")
  external make: React.component<props> = "Action"
}

module Portal = {
  @module("@base-ui/react/toast") @scope("Toast")
  external make: React.component<Types.BaseUIComponentProps.t> = "Portal"
}

module Positioner = {
  @module("@base-ui/react/toast") @scope("Toast")
  external make: React.component<Types.BaseUIComponentProps.t> = "Positioner"
}

module Arrow = {
  @module("@base-ui/react/toast") @scope("Toast")
  external make: React.component<Types.BaseUIComponentProps.t> = "Arrow"
}
