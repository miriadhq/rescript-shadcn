@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (date, setDate) = React.useState(() => {
    let year = Date.make()->Date.getFullYear
    let initialDate = Date.makeWithYMD(~year, ~month=0, ~day=12)
    Some(initialDate)
  })

  <Card className="mx-auto w-fit p-0">
    <Card.Content className="p-0">
      <Calendar
        mode=Single
        defaultMonth=?date
        selected=date
        onSelect={(value: option<Date.t>) => setDate(_ => value)}
        showWeekNumber={true}
      />
    </Card.Content>
  </Card>
}
