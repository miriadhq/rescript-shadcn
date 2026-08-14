@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

@@directive("'use client'")

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

module Orientation = ReactAria.Types.Orientation

module Api = {
  type t
  @send external scrollPrev: t => unit = "scrollPrev"
  @send external scrollNext: t => unit = "scrollNext"
  @send external canScrollPrev: t => bool = "canScrollPrev"
  @send external canScrollNext: t => bool = "canScrollNext"
  @send external scrollSnapList: t => array<float> = "scrollSnapList"
  @send external selectedScrollSnap: t => int = "selectedScrollSnap"
  @send external on: (t, string, t => unit) => unit = "on"
  @send external off: (t, string, t => unit) => unit = "off"
}

type carouselRef = ReactDOM.domRef

module EmblaOptions = {
  module AxisOptionType = {
    @unboxed
    type t =
      | @as("x") X
      | @as("y") Y
  }
  type t = {
    active?: bool,
    axis?: AxisOptionType.t,
    container?: Dom.element,
    slides?: array<Dom.element>,
    containScroll?: string,
    direction?: string,
    slidesToScroll?: int,
    align?: string,
    dragFree?: bool,
    dragThreshold?: float,
    inViewThreshold?: float,
    loop?: bool,
    skipSnaps?: bool,
    duration?: float,
    startIndex?: int,
    watchDrag?: bool,
    watchResize?: bool,
    watchSlides?: bool,
    watchFocus?: bool,
  }
}

type emblaPlugin

@module("embla-carousel-react")
external useEmblaCarousel: (
  ~options: EmblaOptions.t=?,
  ~plugins: array<emblaPlugin>=?,
) => (carouselRef, option<Api.t>) = "default"

type carouselContext = {
  carouselRef: carouselRef,
  api: option<Api.t>,
  opts: EmblaOptions.t,
  orientation: Orientation.t,
  scrollPrev: unit => unit,
  scrollNext: unit => unit,
  canScrollPrev: bool,
  canScrollNext: bool,
}

let context: React.Context.t<option<carouselContext>> = React.createContext(None)

@throws(JsExn)
let useCarousel = () =>
  switch React.useContext(context) {
  | Some(context) => context
  | None => JsError.throwWithMessage("useCarousel must be used within a <Carousel />")
  }

type props = {
  orientation?: Orientation.t,
  opts?: EmblaOptions.t,
  plugins?: array<emblaPlugin>,
  setApi?: Api.t => unit,
  onKeyDownCapture?: JsxEvent.Keyboard.t => unit,
  ...ReactAria.Common.elementProps,
}
let domProps: props => ReactAria.Types.DomProps.t = %raw(
  `({orientation, opts, plugins, setApi, ...props}) => props`
)

@react.componentWithProps(props)
let make = (props: props) => {
  let orientation = props.orientation->Option.getOr(Horizontal)
  let opts = props.opts->Option.getOr({})
  let (carouselRef, api) = useEmblaCarousel(
    ~options={
      ...opts,
      axis: switch orientation {
      | Horizontal => X
      | Vertical => Y
      },
    },
    ~plugins=?props.plugins,
  )
  let (canScrollPrev, setCanScrollPrev) = React.useState(() => false)
  let (canScrollNext, setCanScrollNext) = React.useState(() => false)
  let onSelect = (api: Api.t) => {
    setCanScrollPrev(_ => api->Api.canScrollPrev)
    setCanScrollNext(_ => api->Api.canScrollNext)
  }
  let scrollPrev = () =>
    switch api {
    | Some(api) => api->Api.scrollPrev
    | None => ()
    }
  let scrollNext = () =>
    switch api {
    | Some(api) => api->Api.scrollNext
    | None => ()
    }
  React.useEffect(() => {
    switch (api, props.setApi) {
    | (Some(api), Some(setApi)) =>
      setApi(api)
      None
    | _ => None
    }
  }, (api, props.setApi))
  React.useEffect(() => {
    api->Option.map(api => {
      onSelect(api)
      api->Api.on("reInit", onSelect)
      api->Api.on("select", onSelect)
      () => api->Api.off("select", onSelect)
    })
  }, [api])
  let handleKeyDownCapture = React.useCallback(event => {
    switch event->ReactEvent.Keyboard.key {
    | "ArrowLeft" =>
      event->ReactEvent.Keyboard.preventDefault
      scrollPrev()
    | "ArrowRight" =>
      event->ReactEvent.Keyboard.preventDefault
      scrollNext()
    | _ => ()
    }
  }, [scrollPrev, scrollNext])
  let providerValue = Some({
    carouselRef,
    api,
    opts,
    orientation,
    scrollPrev,
    scrollNext,
    canScrollPrev,
    canScrollNext,
  })
  module Provider = {
    let make = React.Context.provider(context)
  }
  <Provider value={providerValue}>
    <div
      {...props->domProps}
      onKeyDownCapture={props.onKeyDownCapture->Option.getOr(handleKeyDownCapture)}
      dataSlot={props.dataSlot->Option.getOr("carousel")}
      className={cn("relative", props.className)}
      role={props.role->Option.getOr("region")}
      ariaRoledescription={props.ariaRoledescription->Option.getOr("carousel")}
    />
  </Provider>
}

module Content = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) => {
    let {carouselRef, orientation} = useCarousel()
    <div dataSlot="carousel-content" ref={carouselRef} className="overflow-hidden">
      <div
        {...props}
        className={cn(
          `flex ${orientation == Orientation.Horizontal ? "-ml-4" : "-mt-4 flex-col"}`,
          props.className,
        )}
      />
    </div>
  }
}

module Item = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) => {
    let {orientation} = useCarousel()
    <div
      {...props}
      role={props.role->Option.getOr("group")}
      ariaRoledescription={props.ariaRoledescription->Option.getOr("slide")}
      dataSlot={props.dataSlot->Option.getOr("carousel-item")}
      className={cn(
        `min-w-0 shrink-0 grow-0 basis-full ${orientation == Orientation.Horizontal
            ? "pl-4"
            : "pt-4"}`,
        props.className,
      )}
    />
  }
}

module Previous = {
  @react.componentWithProps(props)
  let make = (props: Button.props) => {
    let {orientation, scrollPrev, canScrollPrev} = useCarousel()
    let variant = props.variant->Option.getOr(Outline)
    let size = props.size->Option.getOr(IconSm)
    let onPress = switch props.onPress {
    | Some(handler) => handler
    | None => _ => scrollPrev()
    }
    <Button
      {...props}
      className={cn(
        `cn-carousel-previous absolute touch-manipulation ${orientation == Orientation.Horizontal
            ? "inset-y-0 -left-12 my-auto"
            : "-top-12 left-1/2 -translate-x-1/2 rotate-90"}`,
        props.className,
      )}
      variant
      size
      dataSlot={props.dataSlot->Option.getOr("carousel-previous")}
      isDisabled={props.isDisabled->Option.getOr(!canScrollPrev)}
      onPress
    >
      <Icons.ChevronLeft className="cn-rtl-flip" />
      <span className="sr-only"> {"Previous slide"->React.string} </span>
    </Button>
  }
}

module Next = {
  @react.componentWithProps(props)
  let make = (props: Button.props) => {
    let {orientation, scrollNext, canScrollNext} = useCarousel()
    let variant = props.variant->Option.getOr(Outline)
    let size = props.size->Option.getOr(IconSm)
    let onPress = switch props.onPress {
    | Some(handler) => handler
    | None => _ => scrollNext()
    }
    <Button
      {...props}
      className={cn(
        `cn-carousel-next absolute touch-manipulation ${orientation == Orientation.Horizontal
            ? "inset-y-0 -right-12 my-auto"
            : "-bottom-12 left-1/2 -translate-x-1/2 rotate-90"}`,
        props.className,
      )}
      variant
      size
      dataSlot={props.dataSlot->Option.getOr("carousel-next")}
      isDisabled={props.isDisabled->Option.getOr(!canScrollNext)}
      onPress
    >
      <Icons.ChevronRight className="cn-rtl-flip" />
      <span className="sr-only"> {"Next slide"->React.string} </span>
    </Button>
  }
}
