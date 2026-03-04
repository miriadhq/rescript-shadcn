@@directive("'use client'")

@react.component
let make = () =>
  <div className="flex flex-wrap justify-center gap-2">
    <Button variant=Button.Variant.Outline onClick={_ => ()}> {"Top Left"->React.string} </Button>
    <Button variant=Button.Variant.Outline onClick={_ => ()}> {"Top Center"->React.string} </Button>
    <Button variant=Button.Variant.Outline onClick={_ => ()}> {"Top Right"->React.string} </Button>
    <Button variant=Button.Variant.Outline onClick={_ => ()}>
      {"Bottom Left"->React.string}
    </Button>
    <Button variant=Button.Variant.Outline onClick={_ => ()}>
      {"Bottom Center"->React.string}
    </Button>
    <Button variant=Button.Variant.Outline onClick={_ => ()}>
      {"Bottom Right"->React.string}
    </Button>
  </div>
