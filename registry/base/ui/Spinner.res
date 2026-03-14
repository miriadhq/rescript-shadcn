@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

@react.component
let make = (~className=?, ~dataIcon=?, ~dataSlot=?) => {
  <Icons.Loader2
    ?dataIcon
    ?dataSlot
    role="status"
    ariaLabel="Loading"
    className={cn("size-4 animate-spin", className)}
  />
}
