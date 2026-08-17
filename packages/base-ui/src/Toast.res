module ToastObject = {
  type t = {
    id: string,
    title?: string,
    @as("type") type_?: string,
    description?: string,
  }
}

module Priority = {
  @unboxed
  type t =
    | @as("low") Low
    | @as("high") High
}

module ActionProps = {
  type t = {
    children?: React.element,
    onClick?: unit => unit,
  }
}

module AddOptions = {
  type t = {
    id?: string,
    title?: string,
    @as("type") type_?: string,
    description?: string,
    timeout?: int,
    priority?: Priority.t,
    actionProps?: ActionProps.t,
  }
}

module Manager = {
  type t = {
    add: AddOptions.t => string,
    close: option<string> => unit,
    update: (string, AddOptions.t) => unit,
  }
}

module ManagerState = {
  type t = {
    toasts: array<ToastObject.t>,
    add: AddOptions.t => string,
    close: option<string> => unit,
    update: (string, AddOptions.t) => unit,
  }
}

module PromiseMessage = {
  @unboxed
  type t<'value> =
    | Text(string)
    | Resolve('value => string)
}

module PromiseOptions = {
  type t<'value> = {
    loading: string,
    success: PromiseMessage.t<'value>,
    error: string,
  }
}

@send
external promise: (Manager.t, promise<'value>, PromiseOptions.t<'value>) => promise<'value> =
  "promise"

@module("@base-ui/react/toast") @scope("Toast")
external createToastManager: unit => Manager.t = "createToastManager"

@module("@base-ui/react/toast") @scope("Toast")
external useToastManager: unit => ManagerState.t = "useToastManager"

module Root = {
  type props = {
    ...Types.BaseUIComponentProps.t,
    toast?: ToastObject.t,
  }
  @module("@base-ui/react/toast") @scope("Toast")
  external make: React.component<props> = "Root"
}

module Provider = {
  type props = {
    ...Types.BaseUIComponentProps.t,
    timeout?: int,
    limit?: int,
    toastManager?: Manager.t,
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
  @module("@base-ui/react/toast") @scope("Toast")
  external make: React.component<Types.BaseUIComponentProps.t> = "Close"
}

module Action = {
  @module("@base-ui/react/toast") @scope("Toast")
  external make: React.component<Types.BaseUIComponentProps.t> = "Action"
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
