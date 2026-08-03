@@directive("'use client'")

@react.component
let make = (~side=BaseUi.Types.Side.Bottom) => {
  let (libStyle, setLib, _) = Config.LibStyle.use()
  let lib = libStyle.Config.LibStyle.lib

  <DropdownMenu>
    <DropdownMenu.Trigger
      render={<Button
        variant=Outline
        size=Sm
        className="gap-2 bg-background/95 text-foreground shadow-md backdrop-blur supports-[backdrop-filter]:bg-background/80"
      />}
    >
      <span> {"Lib"->React.string} </span>
      <span className="text-muted-foreground capitalize">
        {lib->Config.Lib.toString->React.string}
      </span>
      <Icons.ChevronDown className="size-4" />
    </DropdownMenu.Trigger>
    <DropdownMenu.Content side align=End className="w-40">
      <DropdownMenu.RadioGroup
        value={lib->Config.Lib.toString}
        onValueChange={(nextValue, _) => setLib(_ => nextValue->Config.Lib.fromString)}
      >
        {Config.Lib.all
        ->Array.map(lib =>
          <DropdownMenu.RadioItem key={lib->Config.Lib.toString} value={lib->Config.Lib.toString}>
            <span className="capitalize"> {lib->Config.Lib.toString->React.string} </span>
          </DropdownMenu.RadioItem>
        )
        ->React.array}
      </DropdownMenu.RadioGroup>
    </DropdownMenu.Content>
  </DropdownMenu>
}
