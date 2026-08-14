let items = ["Inbox triage", "Design review", "API contract", "QA pass", "Launch notes", "Metrics follow-up"]
let tags = ["Design", "Engineering", "Marketing", "Product", "Research", "Sales", "Support", "Operations"]

module Items = {
  @react.component
  let make = () =>
    <div className="flex flex-col gap-1.5 p-1.5">
      {items
      ->Array.map(item =>
        <div key=item className="rounded-lg bg-muted px-3 py-2.5 text-sm">
          {item->React.string}
        </div>
      )
      ->React.array}
    </div>
}

module Tags = {
  @react.component
  let make = () =>
    <div className="flex w-max gap-1.5 p-1.5">
      {tags
      ->Array.map(tag =>
        <div key=tag className="shrink-0 rounded-lg bg-muted px-3 py-2.5 text-sm">
          {tag->React.string}
        </div>
      )
      ->React.array}
    </div>
}

module Vertical = {
  @react.component
  let make = (~className, ~label) =>
    <div className="flex flex-col gap-3">
      <div className="overflow-hidden rounded-2xl border">
        <div className={`h-36 ${className} scrollbar-none overflow-y-auto`}>
          <Items />
        </div>
      </div>
      <p className="text-center font-mono text-xs text-muted-foreground">
        {label->React.string}
      </p>
    </div>
}

module Horizontal = {
  @react.component
  let make = (~className, ~label) =>
    <div className="flex flex-col gap-3">
      <div className="overflow-hidden rounded-2xl border">
        <div className={`${className} scrollbar-none overflow-x-auto`}>
          <Tags />
        </div>
      </div>
      <p className="text-center font-mono text-xs text-muted-foreground">
        {label->React.string}
      </p>
    </div>
}

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="mx-auto flex max-w-xs min-w-0 flex-col gap-6">
    <Vertical className="scroll-fade-t" label="scroll-fade-t" />
    <Vertical className="scroll-fade-b" label="scroll-fade-b" />
    <Horizontal className="scroll-fade-s" label="scroll-fade-s" />
    <Horizontal className="scroll-fade-e" label="scroll-fade-e" />
  </div>
