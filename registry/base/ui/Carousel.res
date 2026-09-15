@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

@@directive("'use client'")

open BaseUi.Types

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

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
  orientation: DataOrientation.t,
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

@react.component
let make = (
  ~className=?,
  ~children=?,
  ~id=?,
  ~dir=?,
  ~style=?,
  ~onClick=?,
  ~onMouseEnter=?,
  ~onMouseLeave=?,
  ~orientation=DataOrientation.Horizontal,
  ~opts: EmblaOptions.t={},
  ~plugins=?,
  ~setApi=?,
) => {
  let (carouselRef, api) = useEmblaCarousel(
    ~options={
      ...opts,
      axis: switch orientation {
      | Horizontal => X
      | Vertical | Responsive => Y
      },
    },
    ~plugins?,
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
    switch (api, setApi) {
    | (Some(api), Some(setApi)) =>
      setApi(api)
      None
    | _ => None
    }
  }, [api])
  React.useEffect(() => {
    switch (api, setApi) {
    | (Some(api), Some(setApi)) =>
      setApi(api)
      None
    | _ => None
    }
  }, [setApi])
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
      ?id
      ?dir
      ?style
      ?onClick
      ?onMouseEnter
      ?onMouseLeave
      onKeyDownCapture={handleKeyDownCapture}
      dataSlot="carousel"
      className={cn("relative", className)}
      role="region"
      ariaRoledescription="carousel"
      ?children
    />
  </Provider>
}

module Content = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) => {
    let {carouselRef, orientation} = useCarousel()
    <div dataSlot="carousel-content" ref={carouselRef} className="overflow-hidden">
      <div
        ?id
        ?style
        ?onClick
        ?onKeyDown
        ?children
        className={cn(
          `flex ${orientation == DataOrientation.Horizontal ? "-ml-4" : "-mt-4 flex-col"}`,
          className,
        )}
      />
    </div>
  }
}

module Item = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) => {
    let {orientation} = useCarousel()
    <div
      ?id
      ?style
      ?onClick
      ?onKeyDown
      ?children
      role="group"
      ariaRoledescription="slide"
      dataSlot="carousel-item"
      className={cn(
        `min-w-0 shrink-0 grow-0 basis-full ${orientation == DataOrientation.Horizontal
            ? "pl-4"
            : "pt-4"}`,
        className,
      )}
    />
  }
}

module Previous = {
  @react.componentWithProps(Button.props)
  let make = (props: Button.props) => {
    let {orientation, scrollPrev, canScrollPrev} = useCarousel()
    <Button
      {...props}
      className={cn(
        `cn-carousel-previous absolute touch-manipulation ${orientation == DataOrientation.Horizontal
            ? "inset-y-0 -left-12 my-auto"
            : "-top-12 left-1/2 -translate-x-1/2 rotate-90"}`,
        props.className,
      )}
      variant={props.variant->Option.getOr(Outline)}
      size={props.size->Option.getOr(IconSm)}
      dataSlot={props.dataSlot->Option.getOr("carousel-previous")}
      disabled={props.disabled->Option.getOr(!canScrollPrev)}
      onClick={props.onClick->Option.getOr(_ => scrollPrev())}
    >
      <Icons.ChevronLeft className="cn-rtl-flip" />
      <span className="sr-only"> {"Previous slide"->React.string} </span>
    </Button>
  }
}

module Next = {
  @react.componentWithProps(Button.props)
  let make = (props: Button.props) => {
    let {orientation, scrollNext, canScrollNext} = useCarousel()
    <Button
      {...props}
      className={cn(
        `cn-carousel-next absolute touch-manipulation ${orientation == DataOrientation.Horizontal
            ? "inset-y-0 -right-12 my-auto"
            : "-bottom-12 left-1/2 -translate-x-1/2 rotate-90"}`,
        props.className,
      )}
      variant={props.variant->Option.getOr(Outline)}
      size={props.size->Option.getOr(IconSm)}
      dataSlot={props.dataSlot->Option.getOr("carousel-next")}
      disabled={props.disabled->Option.getOr(!canScrollNext)}
      onClick={props.onClick->Option.getOr(_ => scrollNext())}
    >
      <Icons.ChevronRight className="cn-rtl-flip" />
      <span className="sr-only"> {"Next slide"->React.string} </span>
    </Button>
  }
}
