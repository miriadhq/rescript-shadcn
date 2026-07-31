@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Button
    variant=Outline
    onClick={_ => {
      let toastId = ref(None)
      let id = Toast.toast.add({
        title: "Event created",
        description: "Sunday, December 3 at 9:00 AM",
        actionProps: {
          children: "Undo"->React.string,
          onClick: () => Toast.toast.close(toastId.contents),
        },
      })
      toastId := Some(id)
    }}
  >
    {"Show Toast"->React.string}
  </Button>
