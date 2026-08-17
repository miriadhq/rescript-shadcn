@@directive("'use client'")

let text = `The accessibility review found two focus states that were visually too subtle in dark mode.

I checked the dialog, menu, and drawer paths because each one renders focusable controls inside a layered surface.

The dialog and drawer are fine. The menu needs the hover and focus tokens split so keyboard focus stays visible when the pointer is not involved.

I also recommend keeping the change in the style file instead of the primitive so the other themes can choose their own focus treatment later.`

let previewLength = 180

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (open_, setOpen) = React.useState(() => false)
  let isLong = text->String.length > previewLength
  let preview = `${text->String.slice(~start=0, ~end=previewLength)}...`

  <div className="flex w-full max-w-sm flex-col gap-8 py-12">
    <Bubble variant=Muted>
      <Bubble.Content> {"How can I help you today?"->React.string} </Bubble.Content>
    </Bubble>
    <Bubble variant=Muted align=End>
      <Bubble.Content className="whitespace-pre-line">
        <Collapsible isExpanded={open_} onExpandedChange={open_ => setOpen(_ => open_)}>
          <div> {(open_ || !isLong ? text : preview)->React.string} </div>
          {isLong
            ? <Button slot="trigger" variant=Link className="gap-1 p-0 text-muted-foreground">
                {(open_ ? "Show less" : "Show more")->React.string}
                <Icons.ChevronDown
                  dataIcon="inline-end" className="group-data-panel-open/button:rotate-180"
                />
              </Button>
            : React.null}
        </Collapsible>
      </Bubble.Content>
    </Bubble>
  </div>
}
