@@directive("'use client'")

@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

@send external focusElement: Dom.element => unit = "focus"

module Locale = {
  type t = private {
    code: string,
  }
}

module Day = {
  type t = {date: Date.t}
}

module DayModifiers = {
  type t = {
    focused?: bool,
    selected?: bool,
    outside?: bool,
    @as("range_start") rangeStart?: bool,
    @as("range_end") rangeEnd?: bool,
    @as("range_middle") rangeMiddle?: bool,
  }
}

module Orientation = {
  type t =
    | @as("left") Left
    | @as("right") Right
    | @as("up") Up
    | @as("down") Down
}

module ChevronProps = {
  type t = {
    ...Icons.props,
    orientation?: Orientation.t,
  }
}

module RootProps = {
  type t = {
    className?: string,
    children?: React.element,
    rootRef?: JsxDOM.domRef,
    id?: string,
    style?: ReactDOM.Style.t,
    onClick?: JsxEvent.Mouse.t => unit,
    onKeyDown?: JsxEvent.Keyboard.t => unit,
    @as("data-mode") dataMode?: string,
    @as("data-week-numbers") dataWeekNumbers?: bool,
    @as("data-multiple-months") dataMultipleMonths?: bool,
  }
}

module WeekNumberProps = {
  type t = {
    className?: string,
    children?: React.element,
    @as("aria-label") ariaLabel?: string,
    role?: string,
    scope?: string,
    week?: int,
  }
}

module Modifiers = {
  type t = {
    selected?: bool,
    disabled?: bool,
    today?: bool,
  }
}

module DayButtonProps = {
  type t = {
    className?: string,
    children: React.element,
    day: Day.t,
    modifiers: DayModifiers.t,
    locale?: Locale.t,
    id?: string,
    style?: ReactDOM.Style.t,
    disabled?: bool,
    tabIndex?: int,
    onClick?: JsxEvent.Mouse.t => unit,
    onKeyDown?: JsxEvent.Keyboard.t => unit,
    onBlur?: ReactEvent.Focus.t => unit,
    onFocus?: ReactEvent.Focus.t => unit,
    onMouseEnter?: ReactEvent.Mouse.t => unit,
    onMouseLeave?: ReactEvent.Mouse.t => unit,
    @as("aria-label") ariaLabel?: string,
  }
}

module DayPickerClassNames = {
  type t = {
    root?: string,
    months?: string,
    month?: string,
    nav?: string,
    @as("button_previous") buttonPrevious?: string,
    @as("button_next") buttonNext?: string,
    @as("month_caption") monthCaption?: string,
    dropdowns?: string,
    @as("dropdown_root") dropdownRoot?: string,
    dropdown?: string,
    @as("caption_label") captionLabel?: string,
    table?: string,
    weekdays?: string,
    weekday?: string,
    week?: string,
    @as("week_number_header") weekNumberHeader?: string,
    @as("week_number") weekNumber?: string,
    day?: string,
    @as("range_start") rangeStart?: string,
    @as("range_middle") rangeMiddle?: string,
    @as("range_end") rangeEnd?: string,
    today?: string,
    outside?: string,
    disabled?: string,
    hidden?: string,
  }
}

@module("react-day-picker")
external getDefaultClassNames: unit => DayPickerClassNames.t = "getDefaultClassNames"

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

@module("tailwind-merge")
external cn4: (
  string,
  string,
  ~additional: option<string>=?,
  ~additional2: option<string>=?,
) => string = "twMerge"

module DayButton = {
  @react.componentWithProps
  let make = ({
    DayButtonProps.className: ?className,
    children,
    day,
    modifiers,
    ?locale,
    ?id,
    ?style,
    ?disabled,
    ?tabIndex,
    ?onClick,
    ?onKeyDown,
    ?onBlur,
    ?onFocus,
    ?onMouseEnter,
    ?onMouseLeave,
    ?ariaLabel,
  }) => {
    let defaultClassNames = getDefaultClassNames()
    let buttonRef = React.useRef(null)
    React.useEffect(() => {
      if modifiers.focused->Option.getOr(false) {
        buttonRef.current->Nullable.forEach(focusElement)
      }
      None
    }, [modifiers.focused])
    <Button
      ?id
      ?style
      ?disabled
      ?tabIndex
      ?onClick
      ?onKeyDown
      ?onBlur
      ?onFocus
      ?onMouseEnter
      ?onMouseLeave
      ?ariaLabel
      variant=Ghost
      size=Icon
      ref={buttonRef->ReactDOM.Ref.domRef}
      dataSlot="button"
      suppressHydrationWarning=true
      dataDay={switch locale {
      | Some({code}) => Date.toLocaleDateStringWithLocale(day.Day.date, code)
      | None => Date.toLocaleDateString(day.Day.date)
      }}
      dataSelectedSingle={modifiers.selected->Option.getOr(false) &&
      !(modifiers.rangeStart->Option.getOr(false)) &&
      !(modifiers.rangeEnd->Option.getOr(false)) &&
      !(modifiers.rangeMiddle->Option.getOr(false))}
      dataRangeStart=?{modifiers.rangeStart}
      dataRangeEnd=?{modifiers.rangeEnd}
      dataRangeMiddle=?{modifiers.rangeMiddle}
      className={cn4(
        "relative isolate z-10 flex aspect-square size-auto w-full min-w-(--cell-size) flex-col gap-1 border-0 leading-none font-normal group-data-[focused=true]/day:relative group-data-[focused=true]/day:z-10 group-data-[focused=true]/day:border-ring group-data-[focused=true]/day:ring-[3px] group-data-[focused=true]/day:ring-ring/50 data-[range-end=true]:rounded-(--cell-radius) data-[range-end=true]:rounded-r-(--cell-radius) data-[range-end=true]:bg-primary data-[range-end=true]:text-primary-foreground data-[range-middle=true]:rounded-none data-[range-middle=true]:bg-muted data-[range-middle=true]:text-foreground data-[range-start=true]:rounded-(--cell-radius) data-[range-start=true]:rounded-l-(--cell-radius) data-[range-start=true]:bg-primary data-[range-start=true]:text-primary-foreground data-[selected-single=true]:bg-primary data-[selected-single=true]:text-primary-foreground dark:hover:text-foreground [&>span]:text-xs [&>span]:opacity-70",
        defaultClassNames.day->Option.getOr(""),
        ~additional=className,
      )}
    >
      {children}
    </Button>
  }
}

module ComponentProps = {
  type t = {
    modifiers?: Modifiers.t,
    ...JsxDOM.domProps,
  }
}

type componentRenderer = ComponentProps.t => React.element

module DayPickerFormatters = {
  module DateLibOptions = {
    type t = {
      locale?: Locale.t,
      timeZone?: string,
      numerals?: string,
    }
  }
  type t = {
    formatMonthDropdown?: Date.t => string,
    formatCaption?: (Date.t, ~options: DateLibOptions.t=?) => string,
    formatDay?: (Date.t, ~options: DateLibOptions.t) => string,
    formatWeekdayName?: (Date.t, ~options: DateLibOptions.t=?) => string,
    formatWeekNumber?: int => string,
    formatYearDropdown?: int => string,
    formatMonthCaption?: (Date.t, ~options: DateLibOptions.t=?) => string,
  }
}

module DayPickerComponents = {
  type t = {
    @as("Root") root?: RootProps.t => React.element,
    @as("Chevron") chevron?: ChevronProps.t => React.element,
    @as("DayButton") dayButton?: DayButtonProps.t => React.element,
    @as("WeekNumber") weekNumber?: WeekNumberProps.t => React.element,
    @as("Months") months?: componentRenderer,
    @as("Month") month?: componentRenderer,
    @as("MonthCaption") monthCaption?: componentRenderer,
    @as("DropdownNav") dropdownNav?: componentRenderer,
    @as("Dropdown") dropdown?: componentRenderer,
    @as("CaptionLabel") captionLabel?: componentRenderer,
    @as("Nav") nav?: componentRenderer,
    @as("Weekdays") weekdays?: componentRenderer,
    @as("Weekday") weekday?: componentRenderer,
    @as("Week") week?: componentRenderer,
    @as("Day") day?: componentRenderer,
    @as("Footer") footer?: componentRenderer,
    @as("PreviousMonthButton") previousMonthButton?: componentRenderer,
    @as("NextMonthButton") nextMonthButton?: componentRenderer,
    @as("MonthGrid") monthGrid?: componentRenderer,
    @as("Select") select?: componentRenderer,
    @as("Option") option?: componentRenderer,
    @as("MonthsDropdown") monthsDropdown?: componentRenderer,
    @as("YearsDropdown") yearsDropdown?: componentRenderer,
    @as("Weeks") weeks?: componentRenderer,
    @as("WeekNumberHeader") weekNumberHeader?: componentRenderer,
    @as("Button") button?: componentRenderer,
  }
}

module CaptionLayout = {
  type t =
    | @as("label") Label
    | @as("dropdown") Dropdown
    | @as("dropdown-months") DropdownMonths
    | @as("dropdown-years") DropdownYears
}

module Labels = {
  type t = {
    labelNav: unit => string,
    labelGrid: Date.t => string,
    labelGridcell: (Date.t, ~modifiers: Modifiers.t=?) => string,
    labelMonthDropdown: unit => string,
    labelYearDropdown: unit => string,
    labelNext: (~nextMonth: Date.t=?) => string,
    labelPrevious: (~previousMonth: Date.t=?) => string,
    labelDayButton: (Date.t, ~modifiers: Modifiers.t=?) => string,
    labelWeekday: Date.t => string,
    labelWeekNumber: int => string,
    labelWeekNumberHeader: unit => string,
  }
}

module Direction = {
  @unboxed
  type t =
    | @as("ltr") Ltr
    | @as("rtl") Rtl
}

module DateRange = {
  type t = {
    from: Date.t,
    to?: Date.t,
  }
}

module DayPicker = {
  module SelectionMode = {
    type rec t<_> =
      | @as("single") Single: t<Date.t>
      | @as("multiple") Multiple: t<array<Date.t>>
      | @as("range") Range: t<DateRange.t>
      | @as("none") NoSelection: t<unit>
  }

  module Props = {
    type t<'selected> = {
      showOutsideDays?: bool,
      className?: string,
      captionLayout?: CaptionLayout.t,
      dir?: Direction.t,
      locale?: Locale.t,
      formatters?: DayPickerFormatters.t,
      classNames?: DayPickerClassNames.t,
      required?: bool,
      mode?: SelectionMode.t<'selected>,
      selected?: 'selected,
      onSelect?: option<'selected> => unit,
      defaultMonth?: Date.t,
      month?: Date.t,
      onMonthChange?: Date.t => unit,
      startMonth?: Date.t,
      endMonth?: Date.t,
      numberOfMonths?: int,
      reverseMonths?: bool,
      pagedNavigation?: bool,
      navLayout?: string,
      hideNavigation?: bool,
      disableNavigation?: bool,
      showWeekNumber?: bool,
      fixedWeeks?: bool,
      weekStartsOn?: int,
      @as("ISOWeek") isoWeek?: bool,
      fromDate?: Date.t,
      toDate?: Date.t,
      fromMonth?: Date.t,
      toMonth?: Date.t,
      fromYear?: int,
      toYear?: int,
      broadcastCalendar?: bool,
      timeZone?: string,
      animate?: bool,
      autoFocus?: bool,
      onDayClick?: (Date.t, Modifiers.t, JsxEvent.Mouse.t) => unit,
      onNextClick?: Date.t => unit,
      onPrevClick?: Date.t => unit,
      styles?: dict<ReactDOM.Style.t>,
      labels?: Labels.t,
      hidden?: Date.t => bool,
      footer?: React.element,
      disabled?: Date.t => bool,
      modifiers?: dict<Date.t => bool>,
      modifiersClassNames?: dict<string>,
      components?: DayPickerComponents.t,
    }
  }

  @module("react-day-picker")
  external make: Props.t<'selected> => React.element = "DayPicker"
}

module Props = {
  type t<'selected> = {
    ...DayPicker.Props.t<'selected>,
    buttonVariant?: Button.Variant.t,
  }
}

let toDayPickerProps = props => {
  module Unsafe = {
    external toDayPickerProps: Props.t<'selected> => DayPicker.Props.t<'selected> = "%identity"
    external toDict: Props.t<'selected> => dict<unknown> = "%identity"
  }
  let propsDict = props->Unsafe.toDict
  Dict.delete(propsDict, "buttonVariant")
  props->Unsafe.toDayPickerProps
}

@scope("Object") external merge: (~defaults: 'a, 'a) => 'a = "assign"

@react.componentWithProps(Props.t)
let make = props => {
  let showOutsideDays = props.Props.showOutsideDays->Option.getOr(true)
  let captionLayout = props.captionLayout->Option.getOr(CaptionLayout.Label)
  let buttonVariant = props.buttonVariant->Option.getOr(Button.Variant.Ghost)
  let formatters = props.formatters->Option.getOr({})
  let classNames = props.classNames->Option.getOr({})
  let components = props.components->Option.getOr({})
  let showWeekNumber = props.showWeekNumber->Option.getOr(false)
  let defaultClassNames = getDefaultClassNames()
  let props = props->toDayPickerProps

  <DayPicker
    {...props}
    showOutsideDays
    className={cn(
      "bg-background group/calendar p-2 [--cell-radius:var(--radius-md)] [--cell-size:--spacing(7)] in-data-[slot=card-content]:bg-transparent in-data-[slot=popover-content]:bg-transparent rtl:**:[.rdp-button\\_next>svg]:rotate-180 rtl:**:[.rdp-button\\_previous>svg]:rotate-180",
      props.className,
    )}
    captionLayout
    formatters={merge(
      ~defaults={
        DayPickerFormatters.formatMonthDropdown: date =>
          date->Date.toLocaleDateStringWithLocaleAndOptions(
            switch props.locale {
            | Some({code}) => code
            | None => "default"
            },
            {month: #short},
          ),
      },
      formatters,
    )}
    classNames={merge(
      ~defaults={
        DayPickerClassNames.root: cn("w-fit", defaultClassNames.root),
        months: cn("flex gap-4 flex-col md:flex-row relative", defaultClassNames.months),
        month: cn("flex flex-col w-full gap-4", defaultClassNames.month),
        nav: cn(
          "flex items-center gap-1 w-full absolute top-0 inset-x-0 justify-between",
          defaultClassNames.nav,
        ),
        buttonPrevious: cn4(
          Button.buttonVariants(~variant=buttonVariant),
          "size-(--cell-size) aria-disabled:opacity-50 p-0 select-none",
          ~additional=defaultClassNames.buttonPrevious,
        ),
        buttonNext: cn4(
          Button.buttonVariants(~variant=buttonVariant),
          "size-(--cell-size) aria-disabled:opacity-50 p-0 select-none",
          ~additional=defaultClassNames.buttonNext,
        ),
        monthCaption: cn(
          "flex items-center justify-center h-(--cell-size) w-full px-(--cell-size)",
          defaultClassNames.monthCaption,
        ),
        dropdowns: cn(
          "w-full flex items-center text-sm font-medium justify-center h-(--cell-size) gap-1.5",
          defaultClassNames.dropdowns,
        ),
        dropdownRoot: cn(
          "relative cn-calendar-dropdown-root rounded-(--cell-radius)",
          defaultClassNames.dropdownRoot,
        ),
        dropdown: cn("absolute bg-popover inset-0 opacity-0", defaultClassNames.dropdown),
        captionLabel: cn4(
          "select-none font-medium",
          switch captionLayout {
          | CaptionLayout.Label => "text-sm"
          | Dropdown => "cn-calendar-caption-label rounded-(--cell-radius) flex items-center gap-1 text-sm [&>svg]:text-muted-foreground [&>svg]:size-3.5"
          | DropdownMonths => "cn-calendar-caption-label rounded-(--cell-radius) flex items-center gap-1 text-sm [&>svg]:text-muted-foreground [&>svg]:size-3.5"
          | DropdownYears => "cn-calendar-caption-label rounded-(--cell-radius) flex items-center gap-1 text-sm [&>svg]:text-muted-foreground [&>svg]:size-3.5"
          },
          ~additional=defaultClassNames.captionLabel,
        ),
        table: cn("w-full border-collapse", defaultClassNames.table),
        weekdays: cn("flex", defaultClassNames.weekdays),
        weekday: cn(
          "text-muted-foreground rounded-(--cell-radius) flex-1 font-normal text-[0.8rem] select-none",
          defaultClassNames.weekday,
        ),
        week: cn("flex w-full mt-2", defaultClassNames.week),
        weekNumberHeader: cn("select-none w-(--cell-size)", defaultClassNames.weekNumberHeader),
        weekNumber: cn(
          "text-[0.8rem] select-none text-muted-foreground",
          defaultClassNames.weekNumber,
        ),
        day: cn4(
          "relative w-full rounded-(--cell-radius) h-full p-0 text-center [&:last-child[data-selected=true]_button]:rounded-r-(--cell-radius) group/day aspect-square select-none",
          showWeekNumber
            ? "[&:nth-child(2)[data-selected=true]_button]:rounded-l-(--cell-radius)"
            : "[&:first-child[data-selected=true]_button]:rounded-l-(--cell-radius)",
          ~additional=defaultClassNames.day,
        ),
        rangeStart: cn(
          "rounded-l-(--cell-radius) bg-muted relative after:bg-muted after:absolute after:inset-y-0 after:w-4 after:right-0 z-0 isolate",
          defaultClassNames.rangeStart,
        ),
        rangeMiddle: cn("rounded-none", defaultClassNames.rangeMiddle),
        rangeEnd: cn(
          "rounded-r-(--cell-radius) bg-muted relative after:bg-muted after:absolute after:inset-y-0 after:w-4 after:left-0 z-0 isolate",
          defaultClassNames.rangeEnd,
        ),
        today: cn(
          "bg-muted text-foreground rounded-(--cell-radius) data-[selected=true]:rounded-none",
          defaultClassNames.today,
        ),
        outside: cn(
          "text-muted-foreground aria-selected:text-muted-foreground",
          defaultClassNames.outside,
        ),
        disabled: cn("text-muted-foreground opacity-50", defaultClassNames.disabled),
      },
      classNames,
    )}
    components={merge(
      ~defaults={
        DayPickerComponents.root: ({
          ?className,
          ?children,
          ?rootRef,
          ?id,
          ?style,
          ?onClick,
          ?onKeyDown,
          ?dataMode,
          ?dataWeekNumbers,
          ?dataMultipleMonths,
        }) =>
          <div
            dataSlot="calendar"
            ref=?rootRef
            ?className
            ?children
            ?id
            ?style
            ?onClick
            ?onKeyDown
            ?dataMode
            ?dataWeekNumbers
            ?dataMultipleMonths
          />,
        chevron: (props: ChevronProps.t) => {
          let className = props.className
          let orientation = props.orientation
          let props = ({...props, orientation: ?None} :> Icons.props)
          switch orientation {
          | Some(Left) =>
            <Icons.ChevronLeft {...props} className={cn("cn-rtl-flip size-4", className)} />
          | Some(Right) =>
            <Icons.ChevronRight {...props} className={cn("cn-rtl-flip size-4", className)} />
          | Some(Up | Down) | None =>
            <Icons.ChevronDown {...props} className={cn("size-4", className)} />
          }
        },
        dayButton: (props: DayButtonProps.t) => <DayButton {...props} locale=?{props.locale} />,
        weekNumber: ({?children, ?className, ?ariaLabel, ?role, ?scope}) =>
          <td ?className ?ariaLabel ?role ?scope>
            <div
              className="flex size-(--cell-size) items-center justify-center text-center" ?children
            />
          </td>,
        week: ({?children, ?className, ?role}) =>
          <tr ?className ?role> {children->Option.getOr(React.null)} </tr>,
      },
      components,
    )}
  />
}
