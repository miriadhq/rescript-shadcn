@@directive("'use client'")

module IDate = ReactAria.InternationalizedDate

type formatter
type formatOptions = {dateStyle: string}
@new @scope("Intl")
external makeFormatter: (option<string>, formatOptions) => formatter = "DateTimeFormat"
@send external format: (formatter, Date.t) => string = "format"

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (date, setDate) = React.useState(() => None)
  <Popover.Trigger>
    <Button
      variant=Outline
      dataEmpty={date->Option.isNone}
      className="w-[212px] justify-between text-left font-normal data-[empty=true]:text-muted-foreground"
    >
      {switch date {
      | Some(date) =>
        makeFormatter(None, {dateStyle: "long"})
        ->format(date->IDate.toDate(IDate.getLocalTimeZone()))
        ->React.string
      | None => <span> {"Pick a date"->React.string} </span>
      }}
      <Icons.ChevronDown dataIcon="inline-end" />
    </Button>
    <Popover className="w-auto p-0" placement=BottomStart>
      <Calendar value=?date onChange={date => setDate(_ => Some(date))} />
    </Popover>
  </Popover.Trigger>
}
