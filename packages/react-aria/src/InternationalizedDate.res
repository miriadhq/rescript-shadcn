module Duration = {
  type t = {
    years?: int,
    months?: int,
    weeks?: int,
    days?: int,
    hours?: int,
    minutes?: int,
    seconds?: int,
  }
}

module ZonedDateTime = {
  type t
}

@new @module("@internationalized/date")
external calendarDate: (int, int, int) => Calendar.CalendarDate.t = "CalendarDate"

@module("@internationalized/date")
external parseDate: string => Calendar.CalendarDate.t = "parseDate"

@module("@internationalized/date")
external fromDate: (Date.t, string) => ZonedDateTime.t = "fromDate"

@module("@internationalized/date")
external toCalendarDate: ZonedDateTime.t => Calendar.CalendarDate.t = "toCalendarDate"

@send external add: (Calendar.CalendarDate.t, Duration.t) => Calendar.CalendarDate.t = "add"
@send
external subtract: (Calendar.CalendarDate.t, Duration.t) => Calendar.CalendarDate.t = "subtract"
@send external toDate: (Calendar.CalendarDate.t, string) => Date.t = "toDate"

@module("@internationalized/date")
external getLocalTimeZone: unit => string = "getLocalTimeZone"

@module("@internationalized/date")
external today: string => Calendar.CalendarDate.t = "today"

@module("@internationalized/date")
external isSameDay: (Calendar.CalendarDate.t, Calendar.CalendarDate.t) => bool = "isSameDay"

@module("@internationalized/date")
external isWeekend: (Calendar.CalendarDate.t, string) => bool = "isWeekend"
