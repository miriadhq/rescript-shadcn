@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Button
    variant=Outline
    onClick={_ =>
      Sonner.toast(
        "Event has been created"->React.string,
        ~options={
          description: "Sunday, December 03, 2023 at 9:00 AM"->React.string,
          action: {label: "Undo"->React.string, onClick: () => Console.log("Undo")},
        },
      )}
  >
    {"Show Toast"->React.string}
  </Button>
