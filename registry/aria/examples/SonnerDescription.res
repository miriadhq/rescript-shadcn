@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Button
    variant=Outline
    className="w-fit"
    onClick={_ =>
      Sonner.toast(
        "Event has been created"->React.string,
        ~options={description: "Monday, January 3rd at 6:00pm"->React.string},
      )}
  >
    {"Show Toast"->React.string}
  </Button>
