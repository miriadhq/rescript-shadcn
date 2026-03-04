@@directive("'use client'")

type dateFnsLocale
@module("date-fns/locale") external arSA: dateFnsLocale = "arSA"
type dateFnsFormatOpts = {locale: dateFnsLocale}
@module("date-fns") external format: (Date.t, string) => string = "format"
@module("date-fns")
external formatWithLocale: (Date.t, string, dateFnsFormatOpts) => string = "format"

@module("react-day-picker/locale") external arSADayPicker: Calendar.Locale.t = "arSA"

@react.component
let make = () => {
  let (date, setDate) = React.useState(() => None)

  <Popover>
    <Popover.Trigger
      render={<Button
        variant=Button.Variant.Outline
        dataEmpty=?{date->Option.isNone ? Some(true) : None}
        className="data-[empty=true]:text-muted-foreground w-[212px] justify-between text-left font-normal"
        dir="rtl"
      />}
    >
      {switch date {
      | Some(d) => d->formatWithLocale("PPP", {locale: arSA})->React.string
      | None => <span> {"اختر تاريخًا"->React.string} </span>
      }}
      <Icons.ChevronDown dataIcon="inline-end" />
    </Popover.Trigger>
    <Popover.Content className="w-auto p-0" align=BaseUi.Types.Align.Start dir="rtl">
      <Calendar
        mode="single"
        selected={date}
        onSelect={(value: option<Date.t>) => setDate(_ => value)}
        defaultMonth=?{date}
        dir="rtl"
        locale={arSADayPicker}
      />
    </Popover.Content>
  </Popover>
}
