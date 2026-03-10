@@directive("'use client'")

@module("date-fns") external format: (Date.t, string) => string = "format"

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (date, setDate) = React.useState(() => None)

  <Popover>
    <Popover.Trigger
      render={<Button
        variant=Button.Variant.Outline
        dataEmpty=?{date->Option.isNone ? Some(true) : None}
        className="data-[empty=true]:text-muted-foreground w-[212px] justify-between text-left font-normal"
      />}
    >
      {switch date {
      | Some(d) => d->format("PPP")->React.string
      | None => <span> {"Pick a date"->React.string} </span>
      }}
      <Icons.ChevronDown dataIcon="inline-end" />
    </Popover.Trigger>
    <Popover.Content className="w-auto p-0" align=BaseUi.Types.Align.Start>
      <Calendar
        mode=Single
        selected={date}
        onSelect={(value: option<Date.t>) => setDate(_ => value)}
        defaultMonth=?{date}
      />
    </Popover.Content>
  </Popover>
}
