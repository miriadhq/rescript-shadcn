@@directive("'use client'")

open BaseUi.Types

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

@get external unsafeArrayLength: 'a => int = "length"

let lengthIfArray = value =>
  if Array.isArray(value) {
    Some(unsafeArrayLength(value))
  } else {
    None
  }

@react.component
let make = (
  ~className=?,
  ~id=?,
  ~name=?,
  ~value=?,
  ~defaultValue=?,
  ~onValueChange=?,
  ~min=0.0,
  ~max=100.0,
  ~step=?,
  ~largeStep=?,
  ~disabled=?,
  ~required=?,
  ~readOnly=?,
  ~onClick=?,
  ~onKeyDown=?,
  ~tabIndex=?,
  ~ariaLabel=?,
  ~dir=?,
  ~style=?,
  ~render=?,
  ~orientation=?,
) => {
  let valuesLength =
    value->lengthIfArray->Option.orElse(defaultValue->lengthIfArray)->Option.getOr(2)

  <BaseUi.Slider.Root
    ?id
    ?name
    ?value
    ?defaultValue
    ?onValueChange
    min
    max
    ?step
    ?largeStep
    ?disabled
    ?required
    ?readOnly
    ?onClick
    ?onKeyDown
    ?tabIndex
    ?ariaLabel
    ?dir
    ?style
    ?render
    ?orientation
    dataSlot="slider"
    thumbAlignment=Edge
    className={cn("data-horizontal:w-full data-vertical:h-full", className)}
  >
    <BaseUi.Slider.Control
      className="relative flex w-full touch-none items-center select-none data-disabled:opacity-50 data-vertical:h-full data-vertical:min-h-40 data-vertical:w-auto data-vertical:flex-col"
    >
      <BaseUi.Slider.Track
        dataSlot="slider-track"
        className="relative grow overflow-hidden rounded-full bg-muted select-none data-horizontal:h-1 data-horizontal:w-full data-vertical:h-full data-vertical:w-1"
      >
        <BaseUi.Slider.Indicator
          dataSlot="slider-range"
          className="bg-primary select-none data-horizontal:h-full data-vertical:w-full"
        />
      </BaseUi.Slider.Track>
      {Array.fromInitializer(~length=valuesLength, index =>
        <BaseUi.Slider.Thumb
          dataSlot="slider-thumb"
          key={Int.toString(index)}
          className="relative block size-3 shrink-0 rounded-full border border-ring bg-white ring-ring/50 transition-[color,box-shadow] select-none after:absolute after:-inset-2 hover:ring-3 focus-visible:ring-3 focus-visible:outline-hidden active:ring-3 disabled:pointer-events-none disabled:opacity-50"
        />
      )->React.array}
    </BaseUi.Slider.Control>
  </BaseUi.Slider.Root>
}
