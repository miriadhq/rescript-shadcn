@@directive("'use client'")

module NextThemes = {
  type theme =
    | @as("system") System
    | @as("light") Light
    | @as("dark") Dark
  type themeState = {theme: option<theme>}

  @module("next-themes")
  external useTheme: unit => themeState = "useTheme"
}

module Position = {
  type t =
    | @as("top-left") TopLeft
    | @as("top-right") TopRight
    | @as("bottom-left") BottomLeft
    | @as("bottom-right") BottomRight
    | @as("top-center") TopCenter
    | @as("bottom-center") BottomCenter
}

module ToasterIcons = {
  type t = {
    success: React.element,
    info: React.element,
    warning: React.element,
    error: React.element,
    loading: React.element,
  }
}

module ToastClassNames = {
  type t = {toast: string}
}
module ToastOptions = {
  type t = {classNames: ToastClassNames.t}
}

module Offset = {
  type t = {
    top: string,
    right: string,
    bottom: string,
    left: string,
  }
}

module Dir = {
  type t =
    | @as("rtl") Rtl
    | @as("ltr") Ltr
    | @as("auto") Auto
}

module SwipeDirection = {
  type t =
    | @as("top") Top
    | @as("right") Right
    | @as("bottom") Bottom
    | @as("left") Left
}

module Action = {
  type t = {
    label: React.element,
    onClick: unit => unit,
  }
}

module Options = {
  type t = {
    description?: React.element,
    action?: Action.t,
    position?: Position.t,
    cancel?: React.element,
  }
}
module Promise = {
  module Options = {
    type t<'success, 'error> = {
      loading?: React.element,
      success?: 'success => React.element,
      error?: 'error => React.element,
      description?: 'success => 'error => React.element,
      finally?: unit => promise<unit>,
    }
  }
}
@module("sonner") external toast: (React.element, ~options: Options.t=?) => unit = "toast"
@module("sonner") @scope("toast")
external success: (React.element, ~options: Options.t=?) => unit = "success"
@module("sonner") @scope("toast")
external info: (React.element, ~options: Options.t=?) => unit = "info"
@module("sonner") @scope("toast")
external warning: (React.element, ~options: Options.t=?) => unit = "warning"
@module("sonner") @scope("toast")
external error: (React.element, ~options: Options.t=?) => unit = "error"
@module("sonner") @scope("toast")
external promise: (unit => promise<'success>, Promise.Options.t<'success, 'error>) => unit =
  "promise"

module SonnerPrimitive = {
  @module("sonner") @react.component
  external make: (
    ~id: string=?,
    ~invert: bool=?,
    ~theme: NextThemes.theme=?,
    ~position: Position.t=?,
    ~hotkey: array<string>=?,
    ~richColors: bool=?,
    ~expand: bool=?,
    ~duration: int=?,
    ~gap: int=?,
    ~visibleToasts: int=?,
    ~closeButton: bool=?,
    ~toastOptions: ToastOptions.t=?,
    ~className: string=?,
    ~style: ReactDOM.Style.t=?,
    ~offset: Offset.t=?,
    ~mobileOffset: Offset.t=?,
    ~dir: Dir.t=?,
    ~swipeDirections: array<SwipeDirection.t>=?,
    ~icons: ToasterIcons.t=?,
    ~containerAriaLabel: string=?,
  ) => React.element = "Toaster"
}

@react.component
let make = (
  ~id=?,
  ~invert=?,
  ~theme=?,
  ~position=?,
  ~hotkey=?,
  ~richColors=?,
  ~expand=?,
  ~duration=?,
  ~gap=?,
  ~visibleToasts=?,
  ~closeButton=?,
  ~toastOptions={ToastOptions.classNames: {toast: "cn-toast"}},
  ~className="toaster group",
  ~style=ReactDOM.Style._dictToStyle(
    dict{
      "--normal-bg": "var(--popover)",
      "--normal-text": "var(--popover-foreground)",
      "--normal-border": "var(--border)",
      "--border-radius": "var(--radius)",
    },
  ),
  ~offset=?,
  ~mobileOffset=?,
  ~dir=?,
  ~swipeDirections=?,
  ~icons={
    ToasterIcons.success: <Icons.CircleCheck className="size-4" />,
    info: <Icons.Info className="size-4" />,
    warning: <Icons.TriangleAlert className="size-4" />,
    error: <Icons.OctagonX className="size-4" />,
    loading: <Icons.Loader2 className="size-4 animate-spin" />,
  },
  ~containerAriaLabel=?,
) => {
  let {theme: defaultTheme} = NextThemes.useTheme()
  let theme = theme->Option.getOr(defaultTheme)->Option.getOr(System)

  <SonnerPrimitive
    ?id
    ?invert
    theme
    ?position
    ?hotkey
    ?richColors
    ?expand
    ?duration
    ?gap
    ?visibleToasts
    ?closeButton
    toastOptions
    className
    style
    ?offset
    ?mobileOffset
    ?dir
    ?swipeDirections
    icons
    ?containerAriaLabel
  />
}
