@@directive("'use client'")

@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

module CaptionLayout = {
  @unboxed
  type t =
    | @as("label") Label
    | @as("dropdown") Dropdown
}

type extraProps = {
  buttonVariant?: Button.Variant.t,
  captionLayout?: CaptionLayout.t,
  numberOfMonths?: int,
  showWeekNumber?: bool,
  headerFormat?: JSON.t,
  renderCell?: ReactAria.Calendar.Cell.renderProps => React.element,
}

type props<'date> = {
  ...ReactAria.Calendar.props<'date>,
  ...extraProps,
}

let calendarProps: props<'date> => ReactAria.Calendar.props<'date> = %raw(`({
  buttonVariant,
  captionLayout,
  numberOfMonths,
  showWeekNumber,
  headerFormat,
  renderCell,
  ...props
}) => props`)

let cellClass = (~showWeekNumber, state: ReactAria.Calendar.Cell.renderProps) => {
  let variants = [
    showWeekNumber
      ? "[&:is(:nth-child(2)>[data-selected=true])>div]:rounded-l-(--cell-radius)"
      : "[&:is(:first-child>[data-selected=true])>div]:rounded-l-(--cell-radius)",
    state.isToday
      ? "rounded-(--cell-radius) bg-muted text-foreground data-[selected=true]:rounded-none"
      : "",
    state.isSelectionStart
      ? "relative isolate z-0 rounded-l-(--cell-radius) bg-muted after:absolute after:inset-y-0 after:right-0 after:w-4 after:bg-muted"
      : "",
    state.isSelectionEnd
      ? "relative isolate z-0 rounded-r-(--cell-radius) bg-muted after:absolute after:inset-y-0 after:left-0 after:w-4 after:bg-muted"
      : "",
    state.isUnavailable ? "text-muted-foreground opacity-50 [&>div]:line-through" : "",
    state.isDisabled ? "text-muted-foreground opacity-50" : "",
    state.isOutsideMonth
      ? "text-muted-foreground aria-selected:text-muted-foreground"
      : "",
  ]->Array.join(" ")
  `group/day relative mt-2 aspect-square h-full w-full cursor-default rounded-(--cell-radius) p-0 text-center select-none [&:is(:last-child>[data-selected=true])>div]:rounded-r-(--cell-radius) ${variants}`
}

let dayButtonClass = Button.buttonVariants(~variant=Ghost, ~size=Icon) ++
  " cn-calendar-day-button relative isolate z-10 flex aspect-square h-full w-full min-w-(--cell-size) flex-col gap-1 border-0 leading-none font-normal group-data-[focused=true]/day:relative group-data-[focused=true]/day:z-10 group-data-[focused=true]/day:border-ring group-data-[focused=true]/day:ring-[3px] group-data-[focused=true]/day:ring-ring/50 data-[range-end=true]:rounded-(--cell-radius) data-[range-end=true]:rounded-r-(--cell-radius) data-[range-end=true]:bg-primary data-[range-end=true]:text-primary-foreground data-[range-middle=true]:rounded-none data-[range-middle=true]:bg-muted data-[range-middle=true]:text-foreground data-[range-start=true]:rounded-(--cell-radius) data-[range-start=true]:rounded-l-(--cell-radius) data-[range-start=true]:bg-primary data-[range-start=true]:text-primary-foreground data-[selected-single=true]:bg-primary data-[selected-single=true]:text-primary-foreground dark:hover:text-foreground [&>span]:text-xs [&>span]:opacity-70"

module MonthDropdown = {
  @react.component
  let make = (~format=?) =>
    <ReactAria.Calendar.MonthPicker ?format>
      {pickerProps =>
        <Select
          items={pickerProps.items}
          value={pickerProps.value}
          onChange={value => pickerProps.onChange(value->Nullable.make)}
          ariaLabel={pickerProps.ariaLabel}
          className="relative"
        >
          <Select.Trigger>
            <Select.Value />
          </Select.Trigger>
          <Select.Content className="min-w-0">
            <Select.Group>
              {pickerProps.items
              ->Array.map(item =>
                <Select.Item key={item.id->Int.toString} id={item.id}>
                  {item.formatted->React.string}
                </Select.Item>
              )
              ->React.array}
            </Select.Group>
          </Select.Content>
        </Select>}
    </ReactAria.Calendar.MonthPicker>
}

module YearDropdown = {
  @react.component
  let make = (~format=?) =>
    <ReactAria.Calendar.YearPicker ?format>
      {pickerProps =>
        <Select
          items={pickerProps.items}
          value={pickerProps.value}
          onChange={value => pickerProps.onChange(value->Nullable.make)}
          ariaLabel={pickerProps.ariaLabel}
          className="relative"
        >
          <Select.Trigger>
            <Select.Value />
          </Select.Trigger>
          <Select.Content className="min-w-0">
            {pickerProps.items
            ->Array.map(item =>
              <Select.Item key={item.id->Int.toString} id={item.id}>
                {item.formatted->React.string}
              </Select.Item>
            )
            ->React.array}
          </Select.Content>
        </Select>}
    </ReactAria.Calendar.YearPicker>
}

@get external getMonthFormat: JSON.t => nullable<string> = "month"

module Inner = {
  @react.component
  let make = (
    ~captionLayout=CaptionLayout.Label,
    ~buttonVariant=Button.Variant.Ghost,
    ~numberOfMonths=1,
    ~showWeekNumber=false,
    ~headerFormat: option<JSON.t>=?,
    ~renderCell=?,
    ~isRange=false,
  ) =>
    <div className="relative flex flex-col gap-4 md:flex-row">
      <header className="absolute inset-x-0 top-0 flex w-full items-center justify-between gap-1">
        <Button
          variant=buttonVariant
          slot="previous"
          className="size-(--cell-size) p-0 select-none aria-disabled:opacity-50"
        >
          <Icons.ChevronLeft className="cn-rtl-flip size-4" />
        </Button>
        <Button
          variant=buttonVariant
          slot="next"
          className="size-(--cell-size) p-0 select-none aria-disabled:opacity-50"
        >
          <Icons.ChevronRight className="cn-rtl-flip size-4" />
        </Button>
      </header>
      {Array.fromInitializer(~length=numberOfMonths, index =>
        <div key={index->Int.toString} className="flex w-full flex-col gap-4">
          <div className="flex h-(--cell-size) w-full items-center justify-center gap-1 px-(--cell-size)">
            {switch captionLayout {
            | Dropdown =>
              let monthFormat = headerFormat->Option.flatMap(format =>
                format->getMonthFormat->Nullable.toOption
              )
              <>
                <MonthDropdown format=?monthFormat />
                <YearDropdown format=?headerFormat />
              </>
            | Label =>
              <ReactAria.Calendar.Heading
                offset={{months: index}}
                format=?headerFormat
                className="cn-calendar-caption text-sm font-medium select-none"
              />
            }}
          </div>
          <ReactAria.Calendar.Grid className="w-full border-collapse" offset={{months: index}}>
            <ReactAria.Calendar.GridHeader>
              {day =>
                <ReactAria.Calendar.HeaderCell className="rounded-(--cell-radius) text-[0.8rem] font-normal text-muted-foreground select-none">
                  {day->React.string}
                </ReactAria.Calendar.HeaderCell>}
            </ReactAria.Calendar.GridHeader>
            <ReactAria.Calendar.GridBody>
              {date =>
                <ReactAria.Calendar.Cell
                  date
                  className={ReactAria.Calendar.Cell.renderClassName(state =>
                    cellClass(~showWeekNumber, state)
                  )}
                >
                  {state =>
                    <div
                      dataSelectedSingle={state.isSelected && !isRange}
                      dataRangeStart={state.isSelectionStart && isRange}
                      dataRangeEnd={state.isSelectionEnd && isRange}
                      dataRangeMiddle={state.isSelected &&
                      !state.isSelectionStart &&
                      !state.isSelectionEnd &&
                      isRange}
                      className=dayButtonClass
                    >
                      {switch renderCell {
                      | Some(renderCell) => renderCell(state)
                      | None => state.defaultChildren
                      }}
                    </div>}
                </ReactAria.Calendar.Cell>}
            </ReactAria.Calendar.GridBody>
          </ReactAria.Calendar.Grid>
        </div>
      )->React.array}
    </div>
}

@react.componentWithProps(props)
let make = (props: props<'date>) => {
  let numberOfMonths = props.numberOfMonths->Option.getOr(1)
  <ReactAria.Calendar
    {...props->calendarProps}
    dataSlot="calendar"
    visibleDuration={{months: numberOfMonths}}
    className={cn(
      "cn-calendar group/calendar w-fit bg-background in-data-[slot=card-content]:bg-transparent in-data-[slot=popover-content]:bg-transparent",
      props.className,
    )}
  >
    <Inner
      captionLayout={props.captionLayout->Option.getOr(Label)}
      buttonVariant={props.buttonVariant->Option.getOr(Ghost)}
      numberOfMonths
      showWeekNumber={props.showWeekNumber->Option.getOr(false)}
      headerFormat=?props.headerFormat
      renderCell=?props.renderCell
    />
  </ReactAria.Calendar>
}

module Range = {
  type props<'date> = {
    ...ReactAria.Calendar.Range.props<'date>,
    ...extraProps,
  }

  let calendarProps: props<'date> => ReactAria.Calendar.Range.props<'date> = %raw(`({
    buttonVariant,
    captionLayout,
    numberOfMonths,
    showWeekNumber,
    headerFormat,
    renderCell,
    ...props
  }) => props`)

  @react.componentWithProps(props)
  let make = (props: props<'date>) => {
    let numberOfMonths = props.numberOfMonths->Option.getOr(1)
    <ReactAria.Calendar.Range
      {...props->calendarProps}
      dataSlot="calendar"
      visibleDuration={{months: numberOfMonths}}
      className={cn(
        "cn-calendar group/calendar w-fit bg-background in-data-[slot=card-content]:bg-transparent in-data-[slot=popover-content]:bg-transparent",
        props.className,
      )}
    >
      <Inner
        captionLayout={props.captionLayout->Option.getOr(Label)}
        buttonVariant={props.buttonVariant->Option.getOr(Ghost)}
        numberOfMonths
        showWeekNumber={props.showWeekNumber->Option.getOr(false)}
        headerFormat=?props.headerFormat
        renderCell=?props.renderCell
        isRange=true
      />
    </ReactAria.Calendar.Range>
  }
}
