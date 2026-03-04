@react.component
let make = () =>
  <div className="flex items-center gap-4 [--radius:1.2rem]">
    <Badge>
      <Spinner dataIcon="inline-start" />
      {"Syncing"->React.string}
    </Badge>
    <Badge variant=Badge.Variant.Secondary>
      <Spinner dataIcon="inline-start" />
      {"Updating"->React.string}
    </Badge>
    <Badge variant=Badge.Variant.Outline>
      <Spinner dataIcon="inline-start" />
      {"Processing"->React.string}
    </Badge>
  </div>
