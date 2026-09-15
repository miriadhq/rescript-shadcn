@@directive("'use client'")

@module("cn")
external cn: (string, option<string>) => string = "cn"

@get external unsafeArrayLength: 'a => int = "length"

@react.componentWithProps(BaseUi.Slider.Root.props)
let make = (props: BaseUi.Slider.Root.props<'value>) => {
  let value = props.value
  let defaultValue = props.defaultValue
  let min = props.min->Option.getOr(0.0)
  let max = props.max->Option.getOr(100.0)
  <BaseUi.Slider.Root
    {...props}
    min
    max
    dataSlot={props.dataSlot->Option.getOr("slider")}
    thumbAlignment={props.thumbAlignment->Option.getOr(Edge)}
    className={cn("data-horizontal:w-full data-vertical:h-full", props.className)}
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
