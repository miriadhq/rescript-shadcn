@@directive("'use client'")

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

@get external unsafeArrayLength: 'a => int = "length"

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
      {Array.fromInitializer(
        ~length=switch (value, defaultValue) {
        | (Some(value), _)
        | (_, Some(value)) =>
          Array.isArray(value) ? unsafeArrayLength(value) : 1
        | (None, None) => 2
        },
        index =>
          <BaseUi.Slider.Thumb
            dataSlot="slider-thumb"
            key={Int.toString(index)}
            className="cn-slider-thumb block shrink-0 select-none disabled:pointer-events-none disabled:opacity-50"
          />,
      )->React.array}
    </BaseUi.Slider.Control>
  </BaseUi.Slider.Root>
}
