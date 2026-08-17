@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex flex-wrap gap-2">
    <Button
      variant=Outline
      onClick={_ => {
        let _: string = Toast.toast.add({description: "Event has been created."})
      }}
    >
      {"Default"->React.string}
    </Button>
    <Button
      variant=Outline
      onClick={_ => {
        let _: string = Toast.toast.add({
          type_: "success",
          description: "Event has been created.",
        })
      }}
    >
      {"Success"->React.string}
    </Button>
    <Button
      variant=Outline
      onClick={_ => {
        let _: string = Toast.toast.add({
          type_: "info",
          description: "Arrive 10 minutes before the event.",
        })
      }}
    >
      {"Info"->React.string}
    </Button>
    <Button
      variant=Outline
      onClick={_ => {
        let _: string = Toast.toast.add({
          type_: "warning",
          description: "The event cannot start before 8:00 AM.",
        })
      }}
    >
      {"Warning"->React.string}
    </Button>
    <Button
      variant=Outline
      onClick={_ => {
        let _: string = Toast.toast.add({
          type_: "error",
          description: "The event could not be created.",
          priority: BaseUi.Toast.Priority.High,
        })
      }}
    >
      {"Error"->React.string}
    </Button>
  </div>
