@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

@unboxed
type dataIcon =
  | @as("inline-start") InlineStart
  | @as("inline-end") InlineEnd

@react.component
let make = (
  ~className=?,
  ~dataIcon: option<dataIcon>=?,
  ~dataSlot="spinner",
  ~id=?,
  ~style=?,
  ~size=?,
  ~role="status",
  ~ariaLabel="Loading",
  ~ariaHidden=?,
  ~onClick=?,
  ~onKeyDown=?,
) => {
  <Icons.Loader2
    ?id
    ?style
    ?size
    ?ariaHidden
    ?onClick
    ?onKeyDown
    dataIcon=?{(dataIcon :> option<string>)}
    dataSlot
    role
    ariaLabel
    className={cn("size-4 animate-spin", className)}
  />
}
