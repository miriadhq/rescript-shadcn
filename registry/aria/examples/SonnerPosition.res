@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex flex-wrap justify-center gap-2">
    <Button
      variant=Outline
      onClick={_ =>
        Sonner.toast("Event has been created"->React.string, ~options={position: TopLeft})}
    >
      {"Top Left"->React.string}
    </Button>
    <Button
      variant=Outline
      onClick={_ =>
        Sonner.toast("Event has been created"->React.string, ~options={position: TopCenter})}
    >
      {"Top Center"->React.string}
    </Button>
    <Button
      variant=Outline
      onClick={_ =>
        Sonner.toast("Event has been created"->React.string, ~options={position: TopRight})}
    >
      {"Top Right"->React.string}
    </Button>
    <Button
      variant=Outline
      onClick={_ =>
        Sonner.toast("Event has been created"->React.string, ~options={position: BottomLeft})}
    >
      {"Bottom Left"->React.string}
    </Button>
    <Button
      variant=Outline
      onClick={_ =>
        Sonner.toast("Event has been created"->React.string, ~options={position: BottomCenter})}
    >
      {"Bottom Center"->React.string}
    </Button>
    <Button
      variant=Outline
      onClick={_ =>
        Sonner.toast("Event has been created"->React.string, ~options={position: BottomRight})}
    >
      {"Bottom Right"->React.string}
    </Button>
  </div>
