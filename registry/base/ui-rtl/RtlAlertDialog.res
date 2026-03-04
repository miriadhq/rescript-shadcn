@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

@@directive("'use client'")

@react.component
let make = (
  ~children=React.null,
  ~open_=?,
  ~defaultOpen=?,
  ~onOpenChange=?,
  ~onOpenChangeComplete=?,
) =>
  <BaseUi.AlertDialog.Root
    ?open_ ?defaultOpen ?onOpenChange ?onOpenChangeComplete dataSlot="alert-dialog"
  >
    {children}
  </BaseUi.AlertDialog.Root>

module Trigger = {
  @react.component
  let make = (~children=React.null, ~className="", ~type_="button", ~ariaLabel=?, ~disabled=?) =>
    <BaseUi.AlertDialog.Trigger
      className type_ ?ariaLabel ?disabled dataSlot="alert-dialog-trigger"
    >
      {children}
    </BaseUi.AlertDialog.Trigger>
}

module Portal = {
  @react.component
  let make = (~children=React.null, ~container=?) =>
    <BaseUi.AlertDialog.Portal ?container dataSlot="alert-dialog-portal">
      {children}
    </BaseUi.AlertDialog.Portal>
}

module Overlay = {
  @react.component
  let make = (~className="", ~keepMounted=?) =>
    <BaseUi.AlertDialog.Backdrop
      ?keepMounted
      dataSlot="alert-dialog-overlay"
      className={`data-open:animate-in data-closed:animate-out data-closed:fade-out-0 data-open:fade-in-0 fixed inset-0 isolate z-50 bg-black/10 duration-100 supports-backdrop-filter:backdrop-blur-xs ${className}`}
    />
}

module Content = {
  @react.component
  let make = (
    ~children=React.null,
    ~className="",
    ~dir=?,
    ~dataLang=?,
    ~keepMounted=?,
    ~size=Button.Size.Default,
  ) => {
    <Portal>
      <Overlay />
      <BaseUi.AlertDialog.Popup
        ?dir
        ?dataLang
        ?keepMounted
        dataSlot="alert-dialog-content"
        dataSize={(size :> string)}
        className={`data-open:animate-in data-closed:animate-out data-closed:fade-out-0 data-open:fade-in-0 data-closed:zoom-out-95 data-open:zoom-in-95 bg-background ring-foreground/10 group/alert-dialog-content fixed start-1/2 top-1/2 z-50 grid w-full -translate-x-1/2 -translate-y-1/2 gap-4 rounded-xl p-4 ring-1 duration-100 outline-none data-[size=default]:max-w-xs data-[size=default]:sm:max-w-sm data-[size=sm]:max-w-xs rtl:translate-x-1/2 ${className}`}
      >
        {children}
      </BaseUi.AlertDialog.Popup>
    </Portal>
  }
}

module Header = {
  @react.component
  let make = (~children=React.null, ~className="") =>
    <div
      dataSlot="alert-dialog-header"
      className={`grid grid-rows-[auto_1fr] place-items-center gap-1.5 text-center has-data-[slot=alert-dialog-media]:grid-rows-[auto_auto_1fr] has-data-[slot=alert-dialog-media]:gap-x-4 sm:group-data-[size=default]/alert-dialog-content:place-items-start sm:group-data-[size=default]/alert-dialog-content:text-start sm:group-data-[size=default]/alert-dialog-content:has-data-[slot=alert-dialog-media]:grid-rows-[auto_1fr] ${className}`}
    >
      {children}
    </div>
}

module Footer = {
  @react.component
  let make = (~children=React.null, ~className="") =>
    <div
      dataSlot="alert-dialog-footer"
      className={`bg-muted/50 -mx-4 -mb-4 flex flex-col-reverse gap-2 rounded-b-xl border-t p-4 group-data-[size=sm]/alert-dialog-content:grid group-data-[size=sm]/alert-dialog-content:grid-cols-2 sm:flex-row sm:justify-end ${className}`}
    >
      {children}
    </div>
}

module Media = {
  @react.component
  let make = (~children=React.null, ~className="") =>
    <div
      dataSlot="alert-dialog-media"
      className={`bg-muted mb-2 inline-flex size-10 items-center justify-center rounded-md sm:group-data-[size=default]/alert-dialog-content:row-span-2 *:[svg:not([class*='size-'])]:size-6 ${className}`}
    >
      {children}
    </div>
}

module Title = {
  @react.component
  let make = (~children=React.null, ~className="") =>
    <BaseUi.AlertDialog.Title
      dataSlot="alert-dialog-title"
      className={`text-base font-medium sm:group-data-[size=default]/alert-dialog-content:group-has-data-[slot=alert-dialog-media]/alert-dialog-content:col-start-2 ${className}`}
    >
      {children}
    </BaseUi.AlertDialog.Title>
}

module Description = {
  @react.component
  let make = (~children=React.null, ~className="") =>
    <BaseUi.AlertDialog.Description
      dataSlot="alert-dialog-description"
      className={`text-muted-foreground *:[a]:hover:text-foreground text-sm text-balance md:text-pretty *:[a]:underline *:[a]:underline-offset-3 ${className}`}
    >
      {children}
    </BaseUi.AlertDialog.Description>
}

module Action = {
  @react.component
  let make = (
    ~children=React.null,
    ~className="",
    ~variant=Button.Variant.Default,
    ~size=Button.Size.Default,
  ) => <Button className variant size dataSlot="alert-dialog-action"> {children} </Button>
}

module Cancel = {
  @react.component
  let make = (
    ~children=React.null,
    ~className="",
    ~variant=Button.Variant.Outline,
    ~size=Button.Size.Default,
  ) => {
    <BaseUi.AlertDialog.Close
      dataSlot="alert-dialog-cancel" render={<Button variant size className />}
    >
      {children}
    </BaseUi.AlertDialog.Close>
  }
}
