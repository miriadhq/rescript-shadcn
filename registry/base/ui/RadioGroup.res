@@directive("'use client'")

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

@react.component
let make = (
  ~className=?,
  ~children=?,
  ~id=?,
  ~name=?,
  ~value=?,
  ~defaultValue=?,
  ~onValueChange=?,
  ~disabled=?,
  ~required=?,
  ~readOnly=?,
  ~onClick=?,
  ~onKeyDown=?,
  ~ariaLabel=?,
  ~dir=?,
  ~style=?,
) =>
  <BaseUi.RadioGroup
    ?id
    ?name
    ?value
    ?defaultValue
    ?onValueChange
    ?disabled
    ?required
    ?readOnly
    ?onClick
    ?onKeyDown
    ?ariaLabel
    ?dir
    ?style
    ?children
    dataSlot="radio-group"
    className={cn("grid w-full gap-2", className)}
  />

module Item = {
  @react.component
  let make = (
    ~className=?,
    ~children=React.null,
    ~id=?,
    ~name=?,
    ~value=?,
    ~disabled=?,
    ~required=?,
    ~readOnly=?,
    ~ariaLabel=?,
    ~ariaInvalid=?,
    ~dir=?,
    ~style=?,
    ~render=?,
    ~nativeButton=?,
  ) =>
    <BaseUi.Radio.Root
      ?id
      ?name
      ?value
      ?disabled
      ?required
      ?readOnly
      ?ariaLabel
      ?ariaInvalid
      ?render
      ?nativeButton
      ?dir
      ?style
      dataSlot="radio-group-item"
      className={cn(
        "group/radio-group-item peer relative flex aspect-square size-4 shrink-0 rounded-full border border-input outline-none after:absolute after:-inset-x-3 after:-inset-y-2 focus-visible:border-ring focus-visible:ring-3 focus-visible:ring-ring/50 disabled:cursor-not-allowed disabled:opacity-50 aria-invalid:border-destructive aria-invalid:ring-3 aria-invalid:ring-destructive/20 aria-invalid:aria-checked:border-primary dark:bg-input/30 dark:aria-invalid:border-destructive/50 dark:aria-invalid:ring-destructive/40 data-checked:border-primary data-checked:bg-primary data-checked:text-primary-foreground dark:data-checked:bg-primary",
        className,
      )}
    >
      <BaseUi.Radio.Indicator
        dataSlot="radio-group-indicator" className="flex size-4 items-center justify-center"
      >
        <span
          className="absolute top-1/2 left-1/2 size-2 -translate-x-1/2 -translate-y-1/2 rounded-full bg-primary-foreground"
        />
      </BaseUi.Radio.Indicator>
      {children}
    </BaseUi.Radio.Root>
}
