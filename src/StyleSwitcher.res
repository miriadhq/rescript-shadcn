@@directive("'use client'")

module BodyScope = {
  @react.component
  let make = () => {
    let _ = Config.Selection.use()
    React.null
  }
}

@react.component
let make = (~className="", ~side=BaseUi.Types.Side.Bottom) => {
  let (selection, _, setStyle) = Config.Selection.use()
  let style = selection.Config.Selection.style

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
        <span className="text-muted-foreground capitalize">
          {style->Config.Style.toString->React.string}
        </span>
        <Icons.ChevronDown className="size-4" />
      </DropdownMenu.Trigger>
      <DropdownMenu.Content side align=End className="w-40">
        <DropdownMenu.RadioGroup
          value={style->Config.Style.toString}
          onValueChange={(nextValue, _) => setStyle(_ => nextValue->Config.Style.fromString)}
        >
          {Config.Style.all
          ->Array.map(style =>
            <DropdownMenu.RadioItem
              key={style->Config.Style.toString} value={style->Config.Style.toString}
            >
              <span className="capitalize"> {style->Config.Style.toString->React.string} </span>
            </DropdownMenu.RadioItem>
          )
          ->React.array}
        </DropdownMenu.RadioGroup>
      </DropdownMenu.Content>
    </DropdownMenu>
  </div>
}
