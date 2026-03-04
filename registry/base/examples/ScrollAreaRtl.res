@@directive("'use client'")

let tags = Array.fromInitializer(~length=50, i => `v1.2.0-beta.${Int.toString(50 - i)}`)

@react.component
let make = () =>
  <ScrollArea className="h-72 w-48 rounded-md border" dir="rtl">
    <div className="p-4">
      <h4 className="mb-4 text-sm leading-none font-medium">
        {"العلامات"->React.string}
      </h4>
      {tags
      ->Array.map(tag =>
        <React.Fragment key={tag}>
          <div className="text-sm"> {tag->React.string} </div>
          <Separator className="my-2" />
        </React.Fragment>
      )
      ->React.array}
    </div>
  </ScrollArea>
