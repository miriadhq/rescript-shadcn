type dateValue
type calendarDate = dateValue

type duration = {
  months?: int,
  weeks?: int,
  days?: int,
}

@unboxed
type selectionMode =
  | @as("single") Single
  | @as("multiple") Multiple

type props<'date> = {
  ...Common.elementProps,
  value?: 'date,
  defaultValue?: 'date,
  onChange?: 'date => unit,
  focusedValue?: 'date,
  defaultFocusedValue?: 'date,
  onFocusChange?: 'date => unit,
  minValue?: 'date,
  maxValue?: 'date,
  isDateUnavailable?: 'date => bool,
  isDisabled?: bool,
  isReadOnly?: bool,
  isInvalid?: bool,
  autoFocus?: bool,
  selectionMode?: selectionMode,
  visibleDuration?: duration,
}

@module("react-aria-components")
external make: React.component<props<'date>> = "Calendar"

module Range = {
  type value<'date> = {start: 'date, @as("end") end_: 'date}

  type props<'date> = {
    ...Common.elementProps,
    value?: value<'date>,
    defaultValue?: value<'date>,
    onChange?: value<'date> => unit,
    focusedValue?: 'date,
    defaultFocusedValue?: 'date,
    onFocusChange?: 'date => unit,
    minValue?: 'date,
    maxValue?: 'date,
    isDateUnavailable?: 'date => bool,
    isDisabled?: bool,
    isReadOnly?: bool,
    isInvalid?: bool,
    autoFocus?: bool,
    visibleDuration?: duration,
  }

  @module("react-aria-components")
  external make: React.component<props<'date>> = "RangeCalendar"
}

module Grid = {
  type props = {
    ...Common.elementProps,
    offset?: duration,
    weekdayStyle?: string,
  }

  @module("react-aria-components")
  external make: React.component<props> = "CalendarGrid"
}

module GridHeader = {
  type props = {...Common.baseProps, children: string => React.element}

  @module("react-aria-components")
  external make: React.component<props> = "CalendarGridHeader"
}

module HeaderCell = {
  @module("react-aria-components")
  external make: React.component<Common.elementProps> = "CalendarHeaderCell"
}

module GridBody = {
  type props = {...Common.baseProps, children: calendarDate => React.element}

  @module("react-aria-components")
  external make: React.component<props> = "CalendarGridBody"
}

module Cell = {
  type renderProps = {
    date: calendarDate,
    formattedDate: string,
    defaultChildren: React.element,
    isHovered: bool,
    isPressed: bool,
    isSelected: bool,
    isSelectionStart: bool,
    isSelectionEnd: bool,
    isFocused: bool,
    isFocusVisible: bool,
    isDisabled: bool,
    isOutsideVisibleRange: bool,
    isOutsideMonth: bool,
    isUnavailable: bool,
    isInvalid: bool,
    isToday: bool,
  }

  type props = {
    key?: string,
    ref?: ReactDOM.domRef,
    id?: string,
    style?: ReactDOM.Style.t,
    @as("data-slot") dataSlot?: string,
    date: calendarDate,
    className?: renderProps => string,
    children?: renderProps => React.element,
  }

  external renderClassName: (renderProps => string) => renderProps => string = "%identity"

  @module("react-aria-components")
  external make: React.component<props> = "CalendarCell"
}

module Heading = {
  type props = {
    ...Common.elementProps,
    offset?: duration,
    format?: JSON.t,
  }

  @module("react-aria-components")
  external make: React.component<props> = "CalendarHeading"
}

module Picker = {
  type item = {id: int, date: calendarDate, formatted: string}
  type renderProps = {
    @as("aria-label") ariaLabel: string,
    value: int,
    onChange: nullable<int> => unit,
    items: array<item>,
  }
}

module MonthPicker = {
  type props = {format?: string, children: Picker.renderProps => React.element}

  @module("react-aria-components")
  external make: React.component<props> = "CalendarMonthPicker"
}

module YearPicker = {
  type props = {format?: JSON.t, visibleYears?: int, children: Picker.renderProps => React.element}

  @module("react-aria-components")
  external make: React.component<props> = "CalendarYearPicker"
}
