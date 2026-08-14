let tags = [
  "Design",
  "Engineering",
  "Marketing",
  "Product",
  "Research",
  "Sales",
  "Support",
  "Operations",
  "Finance",
  "Legal",
  "People",
  "Security",
]

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="mx-auto w-full max-w-xs overflow-hidden rounded-2xl border">
    <div className="scroll-fade-x scrollbar-none overflow-x-auto">
      <div className="flex w-max gap-1.5 p-1.5">
        {tags
        ->Array.map(tag =>
          <div key=tag className="shrink-0 rounded-lg bg-muted px-3 py-2.5 text-sm">
            {tag->React.string}
          </div>
        )
        ->React.array}
      </div>
    </div>
  </div>
