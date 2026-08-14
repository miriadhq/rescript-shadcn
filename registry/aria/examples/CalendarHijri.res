@@directive("'use client'")

module IDate = ReactAria.InternationalizedDate

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (date, setDate) = React.useState(() => IDate.calendarDate(2025, 6, 12))

  <ReactAria.I18nProvider locale="fa-AF-u-ca-persian">
    <Calendar value=date onChange={date => setDate(_ => date)} className="rounded-lg border" />
  </ReactAria.I18nProvider>
}
