@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

@react.component
let make = (
  ~className=?,
  ~role="status",
  ~ariaLabel="Loading",
  ~dataIcon=?,
  ~dataSlot=?,
  ~children=?,
) => {
  let _ignoredChildren = children
  <Icons.Loader2
    ?dataIcon ?dataSlot role ariaLabel className={cn("size-4 animate-spin", className)}
  />
}
