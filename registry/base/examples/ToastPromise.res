@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Button
    variant=Outline
    onClick={_ => {
      let task = Promise.make((resolve, _reject) => {
        let _ = setTimeout(() => resolve({"name": "Event"}), 2000)
      })
      let _ = BaseUi.Toast.promise(
        Toast.toast,
        task,
        {
          loading: "Creating event…",
          success: BaseUi.Toast.PromiseMessage.Resolve(data => `${data["name"]} created.`),
          error: "Could not create event.",
        },
      )
    }}
  >
    {"Create Event"->React.string}
  </Button>
