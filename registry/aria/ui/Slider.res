@@directive("'use client'")

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

type props<'value> = {...ReactAria.Slider.props<'value>}

@react.componentWithProps(props)
let make = ({...ReactAria.Slider.props as props}) =>
  <ReactAria.Slider
    {...props}
    dataSlot="slider"
    className={cn(
      "cn-slider group relative flex w-full touch-none items-center select-none data-disabled:opacity-50 data-vertical:h-full data-vertical:w-auto data-vertical:flex-col",
      props.className,
    )}
  >
    {({state}) => <>
      <ReactAria.Slider.Track
        dataSlot="slider-track"
        className="cn-slider-track relative grow overflow-hidden select-none"
      >
        <ReactAria.Slider.Fill
          dataSlot="slider-range"
          className="cn-slider-range absolute select-none data-horizontal:h-full data-vertical:w-full"
        />
      </ReactAria.Slider.Track>
      {state.values
      ->Array.mapWithIndex((_value, index) =>
        <ReactAria.Slider.Thumb
          dataSlot="slider-thumb"
          key={Int.toString(index)}
          index
          className="cn-slider-thumb block shrink-0 select-none group-data-horizontal:top-[50%] group-data-vertical:left-[50%] disabled:pointer-events-none disabled:opacity-50"
        />
      )
      ->React.array}
    </>}
  </ReactAria.Slider>
