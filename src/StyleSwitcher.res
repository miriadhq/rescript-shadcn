@@directive("'use client'")

let styleLabel = style => {
  Config.Style.options
  ->Array.find(option => option.value === style)
  ->Option.map(option => option.label)
  ->Option.getOr("Style")
}

let syncBodyStyleClass: string => unit = %raw(`
function(style) {
  const styleClasses = ["style-vega", "style-nova", "style-lyra", "style-maia", "style-mira", "style-luma", "style-sera", "style-rhea"];
  document.body.classList.remove(...styleClasses);
  document.body.classList.add("style-" + style);
}
`)

module BodyScope = {
  @react.component
  let make = () => {
    let (style, _) = Config.Style.use()

    React.useEffect(() => {
      syncBodyStyleClass(Config.Style.toString(style))
      None
    }, [style])

    React.null
  }
}

@react.component
let make = (~className="", ~side=BaseUi.Types.Side.Bottom) => {
  let (style, setStyle) = Config.Style.use()
  let value = Config.Style.toString(style)

  <div className>
    <DropdownMenu>
      <DropdownMenu.Trigger
        render={<Button
          variant=Outline
          size=Sm
          className="gap-2 bg-background/95 text-foreground shadow-md backdrop-blur supports-[backdrop-filter]:bg-background/80"
        />}
      >
        <span> {"Style"->React.string} </span>
        <span className="text-muted-foreground"> {style->styleLabel->React.string} </span>
        <Icons.ChevronDown className="size-4" />
      </DropdownMenu.Trigger>
      <DropdownMenu.Content
        side
        align=End
        className="w-40"
      >
        <DropdownMenu.RadioGroup
          value
          onValueChange={(nextValue, _) => setStyle(_ => Config.Style.fromString(nextValue))}
        >
          {Config.Style.options
          ->Array.map(option =>
            <DropdownMenu.RadioItem
              key={Config.Style.toString(option.value)}
              value={Config.Style.toString(option.value)}
            >
              {option.label->React.string}
            </DropdownMenu.RadioItem>
          )
          ->React.array}
        </DropdownMenu.RadioGroup>
      </DropdownMenu.Content>
    </DropdownMenu>
  </div>
}
