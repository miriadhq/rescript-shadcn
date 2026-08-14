type dateValue = Calendar.dateValue
type calendarDate = Calendar.calendarDate

type duration = {
  years?: int,
  months?: int,
  weeks?: int,
  days?: int,
  hours?: int,
  minutes?: int,
  seconds?: int,
}

@new @module("@internationalized/date")
external calendarDate: (int, int, int) => calendarDate = "CalendarDate"

@module("@internationalized/date")
external parseDate: string => calendarDate = "parseDate"

@module("@internationalized/date")
external fromDate: (Date.t, string) => dateValue = "fromDate"

@module("@internationalized/date")
external toCalendarDate: dateValue => calendarDate = "toCalendarDate"

@send external add: (calendarDate, duration) => calendarDate = "add"
@send external subtract: (calendarDate, duration) => calendarDate = "subtract"
@send external toDate: (dateValue, string) => Date.t = "toDate"

@module("@internationalized/date")
external getLocalTimeZone: unit => string = "getLocalTimeZone"

@module("@internationalized/date")
external today: string => calendarDate = "today"

@module("@internationalized/date")
external isSameDay: (dateValue, dateValue) => bool = "isSameDay"

@module("@internationalized/date")
external isWeekend: (dateValue, string) => bool = "isWeekend"
