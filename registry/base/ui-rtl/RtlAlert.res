@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

@@directive("'use client'")

@react.component
let make = (~children=React.null, ~className="") =>
  <div
    role="alert"
    dataSlot="alert"
    className={`grid gap-0.5 rounded-lg border px-2.5 py-2 text-start text-sm has-data-[slot=alert-action]:relative has-data-[slot=alert-action]:pe-18 has-[>svg]:grid-cols-[auto_1fr] has-[>svg]:gap-x-2 *:[svg]:row-span-2 *:[svg]:translate-y-0.5 *:[svg]:text-current *:[svg:not([class*='size-'])]:size-4 w-full relative group/alert bg-card text-card-foreground ${className}`}
  >
    {children}
  </div>

module Title = {
  @react.component
  let make = (~children=React.null, ~className="") =>
    <div
      dataSlot="alert-title"
      className={`[&_a]:hover:text-foreground font-medium group-has-[>svg]/alert:col-start-2 [&_a]:underline [&_a]:underline-offset-3 ${className}`}
    >
      {children}
    </div>
}

module Description = {
  @react.component
  let make = (~children=React.null, ~className="") =>
    <div
      dataSlot="alert-description"
      className={`text-muted-foreground [&_a]:hover:text-foreground text-sm text-balance md:text-pretty [&_a]:underline [&_a]:underline-offset-3 [&_p:not(:last-child)]:mb-4 ${className}`}
    >
      {children}
    </div>
}
