module CalendarDate = {
  type t
}

module Duration = {
  type t = {
    months?: int,
    weeks?: int,
    days?: int,
  }
}

module SelectionMode = {
  @unboxed
  type t =
    | @as("single") Single
    | @as("multiple") Multiple
}

type props<'date> = {
  ...Common.ElementProps.t,
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
  selectionMode?: SelectionMode.t,
  visibleDuration?: Duration.t,
}

@module("react-aria-components")
external make: React.component<props<'date>> = "Calendar"

module Range = {
  module Value = {
    type t<'date> = {start: 'date, end: 'date}
  }

  type props<'date> = {
    ...Common.ElementProps.t,
    value?: Value.t<'date>,
    defaultValue?: Value.t<'date>,
    onChange?: Value.t<'date> => unit,
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
    visibleDuration?: Duration.t,
  }

  @module("react-aria-components")
  external make: React.component<props<'date>> = "RangeCalendar"
}

module Grid = {
  type props = {
    ...Common.ElementProps.t,
    offset?: Duration.t,
    weekdayStyle?: string,
  }

  @module("react-aria-components")
  external make: React.component<props> = "CalendarGrid"
}

module GridHeader = {
  type props = {...Common.BaseProps.t, children: string => React.element}

  @module("react-aria-components")
  external make: React.component<props> = "CalendarGridHeader"
}

module HeaderCell = {
  @module("react-aria-components")
  external make: React.component<Common.ElementProps.t> = "CalendarHeaderCell"
}

module GridBody = {
  type props = {...Common.BaseProps.t, children: CalendarDate.t => React.element}

  @module("react-aria-components")
  external make: React.component<props> = "CalendarGridBody"
}

module Cell = {
  module RenderProps = {
    type t = {
      date: CalendarDate.t,
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
  }

  type props = {
    key?: string,
    ref?: ReactDOM.domRef,
    id?: string,
    style?: ReactDOM.Style.t,
    @as("data-slot") dataSlot?: string,
    date: CalendarDate.t,
    className?: RenderProps.t => string,
    children?: RenderProps.t => React.element,
  }

  @module("react-aria-components")
  external make: React.component<props> = "CalendarCell"
}

module Heading = {
  type props = {
    ...Common.ElementProps.t,
    offset?: Duration.t,
    format?: JSON.t,
  }

  @module("react-aria-components")
  external make: React.component<props> = "CalendarHeading"
}

module Picker = {
  module Item = {
    type t = {id: int, date: CalendarDate.t, formatted: string}
  }

  module RenderProps = {
    type t = {
      @as("aria-label") ariaLabel: string,
      value: int,
      onChange: nullable<int> => unit,
      items: array<Item.t>,
    }
  }
}

module MonthPicker = {
  type props = {format?: string, children: Picker.RenderProps.t => React.element}

  @module("react-aria-components")
  external make: React.component<props> = "CalendarMonthPicker"
}

module YearPicker = {
  type props = {
    format?: JSON.t,
    visibleYears?: int,
    children: Picker.RenderProps.t => React.element,
  }

  @module("react-aria-components")
  external make: React.component<props> = "CalendarYearPicker"
}
