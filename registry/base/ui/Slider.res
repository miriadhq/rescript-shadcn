@@directive("'use client'")

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
    min={Float.toString(min)}
    max={Float.toString(max)}
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
      className="cn-slider relative flex w-full touch-none items-center select-none data-disabled:opacity-50 data-vertical:h-full data-vertical:w-auto data-vertical:flex-col"
    >
      <BaseUi.Slider.Track
        dataSlot="slider-track"
        className="cn-slider-track relative grow overflow-hidden select-none"
      >
        <BaseUi.Slider.Indicator
          dataSlot="slider-range"
          className="cn-slider-range select-none data-horizontal:h-full data-vertical:w-full"
        />
      </BaseUi.Slider.Track>
      {Array.fromInitializer(~length=valuesLength, index =>
        <BaseUi.Slider.Thumb
          dataSlot="slider-thumb"
          key={Int.toString(index)}
          className="cn-slider-thumb block shrink-0 select-none disabled:pointer-events-none disabled:opacity-50"
        />
      )->React.array}
    </BaseUi.Slider.Control>
  </BaseUi.Slider.Root>
}
