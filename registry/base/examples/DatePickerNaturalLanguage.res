@@directive("'use client'")

@module("chrono-node") external parseDate: string => Nullable.t<Date.t> = "parseDate"

let formatDate = (date: option<Date.t>) =>
  switch date {
  | None => ""
  | Some(d) =>
    d->Date.toLocaleDateStringWithLocaleAndOptions(
      "en-US",
      {day: #"2-digit", month: #long, year: #numeric},
    )
  }

@react.component
let make = () => {
  let (open_, setOpen) = React.useState(() => false)
  let (value, setValue) = React.useState(() => "In 2 days")
  let (date, setDate) = React.useState(() => parseDate("In 2 days")->Nullable.toOption)

  <Field className="mx-auto max-w-xs">
    <Field.Label htmlFor="date-optional"> {"Schedule Date"->React.string} </Field.Label>
    <InputGroup>
      <InputGroup.Input
        id="date-optional"
        value={value}
        placeholder="Tomorrow or next week"
        onValueChange={(v, _) => {
          setValue(_ => v)
          let parsed = parseDate(v)->Nullable.toOption
          switch parsed {
          | Some(d) => setDate(_ => Some(d))
          | None => ()
          }
        }}
      />
      <InputGroup.Addon align=InlineEnd>
        <Popover open_={open_} onOpenChange={(v, _) => setOpen(_ => v)}>
          <Popover.Trigger
            render={<InputGroup.Button
              id="date-picker" ariaLabel="Select date" variant=Ghost size=IconXs
            />}
          >
            <Icons.Calendar />
            <span className="sr-only"> {"Select date"->React.string} </span>
          </Popover.Trigger>
          <Popover.Content
            className="w-auto overflow-hidden p-0" align=BaseUi.Types.Align.End sideOffset={8.}
          >
            <Calendar
              mode=Single
              selected={date}
              captionLayout={Calendar.CaptionLayout.Dropdown}
              defaultMonth=?{date}
              onSelect={(value: option<Date.t>) => {
                setDate(_ => value)
                setValue(_ => formatDate(value))
                setOpen(_ => false)
              }}
            />
          </Popover.Content>
        </Popover>
      </InputGroup.Addon>
    </InputGroup>
    <div className="text-muted-foreground px-1 text-sm">
      {"Your post will be published on "->React.string}
      <span className="font-medium"> {formatDate(date)->React.string} </span>
      {"."->React.string}
    </div>
  </Field>
}
