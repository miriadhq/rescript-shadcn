@@directive("'use client'")
@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

@send external focusElement: Dom.element => unit = "focus"

@module("tailwind-merge")
external cn: (string, option<string>, ~additional: option<string>=?) => string = "twMerge"

%%raw(`
import { Vazirmatn } from "next/font/google"
const vazirmatn = Vazirmatn({ subsets: ["arabic"] })
const vazirmatnClassName = vazirmatn.className
`)

@val
external vazirmatnClassName: string = "vazirmatnClassName"

module PersianDayPicker = {
  @react.component @module("react-day-picker/persian")
  external make: (
    ~showOutsideDays: bool=?,
    ~className: string=?,
    ~captionLayout: Calendar.CaptionLayout.t=?,
    ~formatters: Calendar.DayPickerFormatters.t=?,
    ~classNames: Calendar.DayPickerClassNames.t=?,
    ~mode: string=?,
    ~selected: 'selected=?,
    ~onSelect: option<'selected> => unit=?,
    ~defaultMonth: Date.t=?,
    ~components: Calendar.DayPickerComponents.t=?,
  ) => React.element = "DayPicker"
}

@scope("Object") external merge: (~defaults: 'a, 'a) => 'a = "assign"

module CalendarDayButton = {
  @react.componentWithProps
  let make = ({
    Calendar.DayButtonProps.className: ?className,
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
    let defaultClassNames = Calendar.getDefaultClassNames()
    let buttonRef = React.useRef(null)

    React.useEffect(() => {
      if modifiers.focused->Option.getOr(false) {
        buttonRef.current->Nullable.forEach(focusElement)
      }
      None
    }, [modifiers.focused])

    let selectedSingle = switch modifiers.selected {
    | Some(true) =>
      Some(
        !(modifiers.rangeStart->Option.getOr(false)) &&
        !(modifiers.rangeEnd->Option.getOr(false)) &&
        !(modifiers.rangeMiddle->Option.getOr(false)),
      )
    | _ => None
    }

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
      ref={buttonRef->ReactDOM.Ref.domRef}
      dataDay={switch locale {
      | Some({code}) => Date.toLocaleDateStringWithLocale(day.Calendar.Day.date, code)
      | None => Date.toLocaleDateString(day.Calendar.Day.date)
      }}
      dataSelectedSingle=?selectedSingle
      dataRangeStart=?{modifiers.rangeStart}
      dataRangeEnd=?{modifiers.rangeEnd}
      dataRangeMiddle=?{modifiers.rangeMiddle}
      variant=Ghost
      size=Icon
      className={cn(
        "data-[selected-single=true]:bg-primary data-[selected-single=true]:text-primary-foreground data-[range-middle=true]:bg-accent data-[range-middle=true]:text-accent-foreground data-[range-start=true]:bg-primary data-[range-start=true]:text-primary-foreground data-[range-end=true]:bg-primary data-[range-end=true]:text-primary-foreground group-data-[focused=true]/day:border-ring group-data-[focused=true]/day:ring-ring/50 dark:hover:text-accent-foreground flex aspect-square size-auto w-full min-w-(--cell-size) flex-col gap-1 leading-none font-normal group-data-[focused=true]/day:relative group-data-[focused=true]/day:z-10 group-data-[focused=true]/day:ring-[3px] data-[range-end=true]:rounded-md data-[range-end=true]:rounded-r-md data-[range-middle=true]:rounded-none data-[range-start=true]:rounded-md data-[range-start=true]:rounded-l-md [&>span]:text-xs [&>span]:opacity-70",
        defaultClassNames.day,
        ~additional=className,
      )}
      suppressHydrationWarning=true
    >
      {children}
    </Button>
  }
}

module HijriCalendar = {
  @react.component
  let make = (
    ~className=?,
    ~classNames: Calendar.DayPickerClassNames.t={},
    ~showOutsideDays=true,
    ~captionLayout=Calendar.CaptionLayout.Label,
    ~buttonVariant=Button.Variant.Ghost,
    ~formatters: Calendar.DayPickerFormatters.t={},
    ~components: Calendar.DayPickerComponents.t={},
    ~mode=?,
    ~selected: option<'selected>=?,
    ~onSelect: option<option<'selected> => unit>=?,
    ~defaultMonth=?,
  ) => {
    let defaultClassNames = Calendar.getDefaultClassNames()
    let captionLabelClassName = switch captionLayout {
    | Label => "text-sm"
    | Dropdown
    | DropdownMonths
    | DropdownYears => "rounded-md pl-2 pr-1 flex items-center gap-1 text-sm h-8 [&>svg]:text-muted-foreground [&>svg]:size-3.5"
    }

    <PersianDayPicker
      showOutsideDays
      className={cn(
        "bg-background group/calendar p-3 [--cell-size:--spacing(8)] [[data-slot=card-content]_&]:bg-transparent [[data-slot=popover-content]_&]:bg-transparent",
        className,
      )}
      captionLayout
      formatters={merge(
        ~defaults={
          Calendar.DayPickerFormatters.formatMonthDropdown: date =>
            date->Date.toLocaleDateStringWithLocaleAndOptions("default", {month: #short}),
        },
        formatters,
      )}
      classNames={merge(
        ~defaults={
          Calendar.DayPickerClassNames.root: cn("w-fit", defaultClassNames.root),
          months: cn("flex gap-4 flex-col md:flex-row relative", defaultClassNames.months),
          month: cn("flex flex-col w-full gap-4", defaultClassNames.month),
          nav: cn(
            "flex items-center gap-1 w-full absolute top-0 inset-x-0 justify-between",
            defaultClassNames.nav,
          ),
          buttonPrevious: cn(
            Button.buttonVariants(~variant=buttonVariant),
            "size-(--cell-size) aria-disabled:opacity-50 p-0 select-none"->Some,
            ~additional=defaultClassNames.buttonPrevious,
          ),
          buttonNext: cn(
            Button.buttonVariants(~variant=buttonVariant),
            "size-(--cell-size) aria-disabled:opacity-50 p-0 select-none"->Some,
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
            "relative has-focus:border-ring border border-input shadow-xs has-focus:ring-ring/50 has-focus:ring-[3px] rounded-md",
            defaultClassNames.dropdownRoot,
          ),
          dropdown: cn("absolute inset-0 opacity-0", defaultClassNames.dropdown),
          captionLabel: cn(
            "select-none font-medium",
            captionLabelClassName->Some,
            ~additional=defaultClassNames.captionLabel,
          ),
          table: "w-full border-collapse",
          weekdays: cn("flex", defaultClassNames.weekdays),
          weekday: cn(
            "text-muted-foreground rounded-md flex-1 font-normal text-[0.8rem] select-none",
            defaultClassNames.weekday,
          ),
          week: cn("flex w-full mt-2", defaultClassNames.week),
          weekNumberHeader: cn("select-none w-(--cell-size)", defaultClassNames.weekNumberHeader),
          weekNumber: cn(
            "text-[0.8rem] select-none text-muted-foreground",
            defaultClassNames.weekNumber,
          ),
          day: cn(
            "relative w-full h-full p-0 text-center [&:first-child[data-selected=true]_button]:rounded-l-md [&:last-child[data-selected=true]_button]:rounded-r-md group/day aspect-square select-none",
            defaultClassNames.day,
          ),
          rangeStart: cn("rounded-l-md bg-accent", defaultClassNames.rangeStart),
          rangeMiddle: cn("rounded-none", defaultClassNames.rangeMiddle),
          rangeEnd: cn("rounded-r-md bg-accent", defaultClassNames.rangeEnd),
          today: cn(
            "bg-accent text-accent-foreground rounded-md data-[selected=true]:rounded-none",
            defaultClassNames.today,
          ),
          outside: cn(
            "text-muted-foreground aria-selected:text-muted-foreground",
            defaultClassNames.outside,
          ),
          disabled: cn("text-muted-foreground opacity-50", defaultClassNames.disabled),
          hidden: cn("invisible", defaultClassNames.hidden),
        },
        classNames,
      )}
      components={merge(
        ~defaults={
          Calendar.DayPickerComponents.root: ({
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
          chevron: (props: Calendar.ChevronProps.t) => {
            let className = props.className->Option.getOr("")
            let orientation = props.orientation
            let iconProps = ({...props, orientation: ?None} :> Icons.props)
            switch orientation {
            | Some(Left) => <Icons.ChevronLeft {...iconProps} className={`size-4 ${className}`} />
            | Some(Right) => <Icons.ChevronRight {...iconProps} className={`size-4 ${className}`} />
            | Some(Up | Down) | None =>
              <Icons.ChevronDown {...iconProps} className={`size-4 ${className}`} />
            }
          },
          dayButton: (props: Calendar.DayButtonProps.t) => <CalendarDayButton {...props} />,
          weekNumber: ({?children, ?className, ?ariaLabel, ?role, ?scope}) =>
            <td ?className ?ariaLabel ?role ?scope>
              <div
                className="flex size-(--cell-size) items-center justify-center text-center"
                ?children
              />
            </td>,
          week: ({?children, ?className, ?role}) =>
            <tr ?className ?role> {children->Option.getOr(React.null)} </tr>,
        },
        components,
      )}
      ?mode
      ?selected
      ?onSelect
      ?defaultMonth
    />
  }
}

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (date, setDate) = React.useState(() => Some(Date.makeWithYMD(~year=2025, ~month=5, ~day=12)))

  <div className={vazirmatnClassName}>
    <HijriCalendar
      mode="single"
      defaultMonth=?date
      selected=?date
      onSelect={value => setDate(_ => value)}
      className="rounded-lg border"
    />
  </div>
}
