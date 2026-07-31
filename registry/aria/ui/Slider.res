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
  ~disabled=?,
  ~onClick=?,
  ~onKeyDown=?,
  ~tabIndex=?,
  ~ariaLabel=?,
  ~dir=?,
  ~style=?,
  ~orientation=?,
) => {
  let valuesLength =
    value->lengthIfArray->Option.orElse(defaultValue->lengthIfArray)->Option.getOr(2)
  let onChange = onValueChange->Option.map(callback => value => callback(value, %raw(`undefined`)))
  <ReactAria.Slider
    ?id
    ?name
    ?value
    ?defaultValue
    ?onChange
    minValue={min}
    maxValue={max}
    ?step
    isDisabled=?disabled
    ?onClick
    ?onKeyDown
    ?tabIndex
    ?ariaLabel
    ?dir
    ?style
    ?orientation
    dataSlot="slider"
    className={cn("data-horizontal:w-full data-vertical:h-full", className)}
  >
    <div
      className="cn-slider relative flex w-full touch-none items-center select-none data-disabled:opacity-50 data-vertical:h-full data-vertical:w-auto data-vertical:flex-col"
    >
      <ReactAria.Slider.Track
        dataSlot="slider-track"
        className="cn-slider-track relative grow overflow-hidden select-none"
      >
        <ReactAria.Slider.Fill
          dataSlot="slider-range"
          className="cn-slider-range select-none data-horizontal:h-full data-vertical:w-full"
        />
      </ReactAria.Slider.Track>
      {Array.fromInitializer(~length=valuesLength, index =>
        <ReactAria.Slider.Thumb
          dataSlot="slider-thumb"
          key={Int.toString(index)}
          className="cn-slider-thumb block shrink-0 select-none data-disabled:pointer-events-none data-disabled:opacity-50"
        />
      )->React.array}
    </div>
  </ReactAria.Slider>
}
