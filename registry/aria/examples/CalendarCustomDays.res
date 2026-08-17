@@directive("'use client'")

module IDate = ReactAria.InternationalizedDate

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let year = Date.make()->Date.getFullYear
  let start = IDate.calendarDate(year, 12, 8)
  let (range, setRange) = React.useState(() => {
    ReactAria.Calendar.Range.Value.start,
    end: start->IDate.add({days: 10}),
  })
  let locale = "en-US"

  <Card className="mx-auto w-fit p-0">
    <Card.Content className="p-0">
      <Calendar.Range
        value=range
        onChange={range => setRange(_ => range)}
        captionLayout=Dropdown
        className="[--cell-size:--spacing(10)] md:[--cell-size:--spacing(12)]"
        renderCell={state => <>
          {state.defaultChildren}
          {state.isOutsideMonth
            ? React.null
            : <span>
                {(state.date->IDate.isWeekend(locale) ? "$120" : "$100")->React.string}
              </span>}
        </>}
      />
    </Card.Content>
  </Card>
}
