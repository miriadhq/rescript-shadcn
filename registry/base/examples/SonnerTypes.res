@@directive("'use client'")

type res = {name: string}

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex flex-wrap gap-2">
    <Button variant=Outline onClick={_ => Sonner.toast("Event has been created"->React.string)}>
      {"Default"->React.string}
    </Button>
    <Button variant=Outline onClick={_ => Sonner.success("Event has been created"->React.string)}>
      {"Success"->React.string}
    </Button>
    <Button
      variant=Outline
      onClick={_ => Sonner.info("Be at the area 10 minutes before the event time"->React.string)}
    >
      {"Info"->React.string}
    </Button>
    <Button
      variant=Outline
      onClick={_ => Sonner.warning("Event start time cannot be earlier than 8am"->React.string)}
    >
      {"Warning"->React.string}
    </Button>
    <Button variant=Outline onClick={_ => Sonner.error("Event has not been created"->React.string)}>
      {"Error"->React.string}
    </Button>
    <Button
      variant=Outline
      onClick={_ =>
        Sonner.promise(
          () =>
            Promise.make((resolve, _reject) => {
              let _ = setTimeout(~handler=() => resolve({name: "Event"}), ~timeout=2000)
            }),
          {
            loading: "Loading..."->React.string,
            success: data => `${data.name} has been created`->React.string,
            error: _ => "Error"->React.string,
          },
        )}
    >
      {"Promise"->React.string}
    </Button>
  </div>
