module Variant = {
  @unboxed
  type t =
    | @as("default") Default
    | @as("info") Info
    | @as("warning") Warning
}

@react.component
let make = (~title=?, ~children, ~icon, ~className=?, ~variant=Variant.Default) => {
  <Alert
    dataVariant={(variant :> string)}
    className={Commons.cn(
      "mt-6 w-auto rounded-xl border-surface bg-surface text-surface-foreground md:-mx-1 **:[code]:border",
      className,
    )}
  >
    {icon}
    {switch title {
    | Some(t) => <Alert.Title> {t} </Alert.Title>
    | None => React.null
    }}
    <Alert.Description className="text-card-foreground/80"> {children} </Alert.Description>
  </Alert>
}
