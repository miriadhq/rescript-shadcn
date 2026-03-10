@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex flex-wrap gap-2">
    <Button variant=Button.Variant.Outline onClick={_ => ()}> {"Default"->React.string} </Button>
    <Button variant=Button.Variant.Outline onClick={_ => ()}> {"Success"->React.string} </Button>
    <Button variant=Button.Variant.Outline onClick={_ => ()}> {"Info"->React.string} </Button>
    <Button variant=Button.Variant.Outline onClick={_ => ()}> {"Warning"->React.string} </Button>
    <Button variant=Button.Variant.Outline onClick={_ => ()}> {"Error"->React.string} </Button>
    <Button variant=Button.Variant.Outline onClick={_ => ()}> {"Promise"->React.string} </Button>
  </div>
