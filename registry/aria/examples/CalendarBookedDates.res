@@directive("'use client'")

module IDate = ReactAria.InternationalizedDate

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let year = Date.make()->Date.getFullYear
  let initialDate = IDate.calendarDate(year, 2, 3)
  let (date, setDate) = React.useState(() => initialDate)
  let bookedDates = Array.fromInitializer(~length=15, index =>
    IDate.calendarDate(year, 2, 12 + index)
  )

  <Card className="mx-auto w-fit p-0">
    <Card.Content className="p-0">
      <Calendar
        value=date
        onChange={date => setDate(_ => date)}
        isDateUnavailable={date =>
          bookedDates->Array.some(booked => IDate.isSameDay(date, booked))}
      />
    </Card.Content>
  </Card>
}
