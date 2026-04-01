@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

@@directive("'use client'")

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

type colorTheme = {
  light?: string,
  dark?: string,
}

type chartConfigItem = {
  label?: React.element,
  icon?: unit => React.element,
  color?: string,
  theme?: colorTheme,
}

type chartConfig = dict<chartConfigItem>

type chartContext = {config: chartConfig}

type payloadItem<'value> = {
  @as("type") type_?: string,
  dataKey?: string,
  name?: string,
  color?: string,
  value?: 'value,
  payload: dict<string>,
}

let chartContext: React.Context.t<option<chartContext>> = React.createContext(None)

@throws(JsExn)
let use = () =>
  switch React.useContext(chartContext) {
  | Some(context) => context
  | None => JsError.throwWithMessage("useChart must be used within a <ChartContainer />")
  }

let themeColor = (~itemConfig: chartConfigItem, ~themeName: string) =>
  switch itemConfig.theme {
  | Some(theme) =>
    switch themeName {
    | "light" => theme.light->Option.orElse(itemConfig.color)
    | "dark" => theme.dark->Option.orElse(itemConfig.color)
    | _ => itemConfig.color
    }
  | None => itemConfig.color
  }

let getPayloadConfigFromPayload = (
  ~config: chartConfig,
  ~payload: payloadItem<'value>,
  ~key: string,
) => {
  let configLabelKey = switch key {
  | "name" => payload.name->Option.orElse(payload.payload->Dict.get("name"))
  | "dataKey" => payload.dataKey->Option.orElse(payload.payload->Dict.get("dataKey"))
  | _ => payload.payload->Dict.get(key)
  }->Option.getOr(key)
  switch config->Dict.get(configLabelKey) {
  | Some(foundConfig) => Some(foundConfig)
  | None => config->Dict.get(key)
  }
}

module Recharts = {
  module Dimensions = {
    type t = {width: float, height: float}
  }
  module ResponsiveContainer = {
    @module("recharts") @react.component
    external make: (
      /**
   * width / height. If specified, the height will be calculated by width / aspect.
   */
      ~aspect: float=?,
      /**
   * The width of chart container.
   * Can be a number or a percent string like "100%".
   * @default '100%'
   */
      ~width: float=?,
      /**
   * The height of chart container.
   * Can be a number or a percent string like "100%".
   * @default '100%'
   */
      ~height: float=?,
      /**
   * The minimum width of the container.
   * @default 0
   */
      ~minWidth: float=?,
      /**
   * The minimum height of the container.
   */
      ~minHeight: float=?,
      /**
   * The initial width and height of the container.
   * @default {"width":-1,"height":-1}
   */
      ~initialDimension: Dimensions.t=?,
      /**
   * The maximum height of the container. It can be a number.
   */
      ~maxHeight: float=?,
      /**
   * The content of the container.
   * It can contain multiple charts, and then they will all share the same dimensions.
   */
      ~children: React.element,
      /**
   * If specified a positive number, debounced function will be used to handle the resize event.
   * @default 0
   */
      ~debounce: float=?,
      /**
   * Unique identifier of this component.
   * Used as an HTML attribute `id`.
   */
      ~id: string=?,
      /**
   * The HTML element's class name
   */
      ~className: string=?,
      /**
   * The style of the container.
   */
      ~style: ReactDOM.Style.t=?,
      /**
   * If specified provides a callback providing the updated chart width and height values.
   */
      ~onResize: (float, float) => unit=?,
    ) => React.element = "ResponsiveContainer"
  }

  module AllowInDimension = {
    type t = {x?: bool, y?: bool}
  }
  module AnimationTiming = {
    @unboxed
    type t =
      | @as("ease") Ease
      | @as("linear") Linear
      | @as("ease-in") EaseIn
      | @as("ease-out") EaseOut
      | @as("ease-in-out") EaseInOut
  }

  module Index = {
    @unboxed
    type t =
      | Int(int)
      | String(string)
  }

  module CursorDefinition = {
    @unboxed
    type t =
      | @as(false) NoCursor
      | Custom(React.element)
  }

  module AnimationActive = {
    @unboxed
    type t =
      | Bool(bool)
      | @as("auto") Auto
  }

  module TooltipItemSorter = {
    @unboxed
    type t<'payloadItem> =
      | @as("name") Name
      | @as("value") Value
      | @as("dataKey") Id
      | Function((~item: 'payloadItem) => int)
  }

  module Coordinate = {
    type t = {x: float, y: float}
    module Partial = {
      type t = {x?: float, y?: float}
    }
  }

  module Offset = {
    @unboxed
    type t =
      | Int(int)
      | Coordinate(Coordinate.t)
  }

  module UniqueOption = {
    @unboxed
    type t<'entry> =
      | Bool(bool)
      | Function('entry => string)
  }

  module TooltipTrigger = {
    @unboxed
    type t =
      | @as("hover") Hover
      | @as("click") Click
  }

  type mouseEvent<'element>

  module Tooltip = {
    @module("recharts") @react.component
    external make: (
      ~wrapperClassName: string=?,
      ~labelClassName: string=?,
      /**
   * If true, then Tooltip is always displayed, once an activeIndex is set by mouse over, or programmatically.
   * If false, then Tooltip is never displayed.
   * If undefined, Recharts will control when the Tooltip displays. This includes mouse and keyboard controls.
   */
      ~active: bool=?,
      /**
   * This option allows the tooltip to extend beyond the viewBox of the chart itself.
   * @defaultValue {"x":false,"y":false}
   */
      ~allowEscapeViewBox: AllowInDimension.t=?,
      /**
   * Specifies the duration of animation, the unit of this option is ms.
   * @defaultValue 400
   */
      ~animationDuration: float=?,
      /**
   * The type of easing function.
   * @defaultValue ease
   */
      ~animationEasing: AnimationTiming.t=?,
      /**
   * Tooltip always attaches itself to the "Tooltip" axis. Which axis is it? Depends on the layout:
   * - horizontal layout -> X axis
   * - vertical layout -> Y axis
   * - radial layout -> radial axis
   * - centric layout -> angle axis
   *
   * Tooltip will use the default axis for the layout, unless you specify an axisId.
   *
   * @defaultValue 0
   */
      ~axisId: Index.t=?,
      /**
   * Renders the content of the tooltip.
   *
   * This should return HTML elements, not SVG elements.
   *
   * - If not set, the {@link DefaultTooltipContent} component is used.
   * - If set to a React element, this element will be cloned and extra props will be passed in.
   * - If set to a function, the function will be called and should return HTML elements.
   *
   * @see {@link https://recharts.github.io/en-US/examples/CustomContentOfTooltip/ Example with custom content}
   */
      ~content: React.element=?,
      /**
   * The style of tooltip content which is a dom element.
   * @defaultValue {}
   */
      ~contentStyle: ReactDOM.Style.t=?,
      /**
   * If set false, no cursor will be drawn when tooltip is active.
   * If set a object, the option is the configuration of cursor.
   * If set a React element, the option is the custom react element of drawing cursor.
   * @defaultValue true
   */
      ~cursor: CursorDefinition.t=?,
      ~defaultIndex: Index.t=?,
      /**
   * When an item of the payload has value null or undefined, this item won't be displayed.
   * @defaultValue true
   */
      ~filterNull: bool=?,
      /**
   * Function to customize the value in the tooltip.
   * If you return an array, the first entry will be the formatted "value", and the second entry will be the formatted "name"
   */
      ~formatter: (
        ~name: string,
        ~value: string,
        ~item: 'payloadItem,
        ~index: int,
        ~payload: array<'payloadEntry>,
      ) => (React.element, React.element)=?,
      /**
   * If true, the tooltip will display information about hidden series.
   * Defaults to false.
   * Interacting with the hide property of Area, Bar, Line, Scatter.
   *
   * @defaultValue false
   */
      ~includeHidden: bool=?,
      /**
   * If set false, animation of tooltip will be disabled.
   * If set "auto", the animation will be disabled in SSR and will respect the user's prefers-reduced-motion system preference for accessibility.
   * @defaultValue auto
   */
      ~isAnimationActive: AnimationActive.t=?,
      /**
   * Sorts tooltip items.
   * Defaults to 'name' which means it sorts alphabetically by graphical item `name` property.
   * @defaultValue name
   */
      ~itemSorter: TooltipItemSorter.t<'payloadItem>=?,
      /**
   * The style of default tooltip content item which is a li element.
   * @defaultValue {}
   */
      ~itemStyle: ReactDOM.Style.t=?,
      /**
   * The formatter function of label in tooltip.
   */
      ~labelFormatter: (~label: 'label, ~payload: 'tooltipPayload) => React.element=?,
      /**
   * The style of default tooltip label which is a p element.
   * @defaultValue {}
   */
      ~labelStyle: ReactDOM.Style.t=?,
      /**
   * The offset size between the position of tooltip and the mouse cursor position.
   * When a number is provided, the same offset is applied to both x and y axes.
   *
   * When a Coordinate object is provided, you can specify different offsets for each axis (x and y as numbers)
   * @defaultValue 10
   */
      ~offset: Offset.t=?,
      ~payloadUniqBy: UniqueOption.t<'payloadEntry>=?,
      /**
   * If portal is defined, then Tooltip will use this element as a target
   * for rendering using React Portal: https://react.dev/reference/react-dom/createPortal
   *
   * If this is undefined then Tooltip renders inside the recharts-wrapper element.
   */
      ~portal: Dom.htmlElement=?,
      /**
   * If this field is set, the tooltip will be displayed at the specified position
   * regardless of the mouse position.
   *
   * You can set a single field (x or y) and let the other field be calculated automatically based
   * on the mouse position.
   */
      ~position: Coordinate.Partial.t=?,
      /**
   * @defaultValue {"x":false,"y":false}
   */
      ~reverseDirection: AllowInDimension.t=?,
      /**
   * The separator between name and value.
   * @defaultValue ' : '
   */
      ~separator: string=?,
      /**
   * Defines whether the tooltip is reacting to the current data point,
   * or to all data points at the current axis coordinate.
   */
      ~shared: bool=?,
      /**
   * If `hover` then the Tooltip shows on mouse enter and hides on mouse leave.
   *
   * If `click` then the Tooltip shows after clicking and stays active.
   *
   * @defaultValue hover
   */
      ~trigger: TooltipTrigger.t=?,
      /**
   * @defaultValue false
   */
      ~useTranslate3d: bool=?,
      /**
   * CSS styles to be applied to the wrapper `div` element.
   */
      ~wrapperStyle: ReactDOM.Style.t=?,
    ) => React.element = "Tooltip"
  }

  module LegendType = {
    @unboxed
    type t =
      | @as("circle") Circle
      | @as("cross") Cross
      | @as("diamond") Diamond
      | @as("line") Line
      | @as("plainline") Plainline
      | @as("rect") Rect
      | @as("square") Square
      | @as("star") Star
      | @as("triangle") Triangle
      | @as("wye") Wye
      | @as("none") None
  }

  module CartesianLayout = {
    @unboxed
    type t =
      | @as("horizontal") Horizontal
      | @as("vertical") Vertical
  }

  module HorizontalAlignmentType = {
    @unboxed
    type t =
      | @as("left") Left
      | @as("right") Right
      | @as("center") Center
  }

  module VerticalAlignmentType = {
    @unboxed
    type t =
      | @as("bottom") Bottom
      | @as("top") Top
      | @as("middle") Middle
  }

  module Dimension = {
    @unboxed
    type t =
      | Int(int)
      | String(string)
  }

  module LegendItemSorter = {
    @unboxed
    type t<'legendPayload> =
      | @as("value") Value
      | @as("dataKey") DataKey
      | Function((~item: 'legendPayload) => string)
  }
  module Legend = {
    @module("recharts") @react.component
    external make: (
      /**
   * The size of icon in each legend item.
   * @defaultValue 14
   */
      ~iconSize: float=?,
      /**
   * The type of icon in each legend item.
   */
      ~iconType: LegendType.t=?,
      /**
   * The layout of legend items inside the legend container.
   * @defaultValue horizontal
   */
      ~layout: CartesianLayout.t=?,
      /**
   * Horizontal alignment of the whole Legend container:
   *
   * - `left`: shows the Legend to the left of the chart, and chart width reduces automatically to make space for it.
   * - `right` shows the Legend to the right of the chart, and chart width reduces automatically.
   * - `center` shows the Legend in the middle of chart, and chart width remains unchanged.
   *
   * The exact behavior changes depending on 'verticalAlign' prop.
   *
   * @defaultValue center
   */
      ~align: HorizontalAlignmentType.t=?,
      /**
   * The color of the icon when the item is inactive.
   * @defaultValue #ccc
   */
      ~inactiveColor: string=?,
      /**
   * Function to customize how content is serialized before rendering.
   *
   * This should return HTML elements, or strings.
   *
   * @example (value, entry, index) => <span style={{ color: 'red' }}>{value}</span>
   * @example https://codesandbox.io/s/legend-formatter-rmzp9
   */
      ~formatter: (~value: 'value, ~entry: 'entry, ~index: int) => React.element=?,
      /**
   * The customized event handler of mouseenter on the items in this group
   * @example https://recharts.github.io/examples/LegendEffectOpacity
   */
      ~onMouseEnter: (
        ~data: 'legendPayload,
        ~index: int,
        ~event: mouseEvent<Dom.htmlElement>,
      ) => unit=?,
      /**
   * The customized event handler of mouseleave on the items in this group
   * @example https://recharts.github.io/examples/LegendEffectOpacity
   */
      ~onMouseLeave: (
        ~data: 'legendPayload,
        ~index: int,
        ~event: mouseEvent<Dom.htmlElement>,
      ) => unit=?,
      /**
   * The customized event handler of click on the items in this group
   */
      ~onClick: (~data: 'legendPayload, ~index: int, ~event: mouseEvent<Dom.htmlElement>) => unit=?,
      /**
   * The style of each text label which is a span element.
   * @defaultValue {}
   */
      ~labelStyle: ReactDOM.Style.t=?,
      /**
   * Renders the content of the legend.
   *
   * This should return HTML elements, not SVG elements.
   *
   * - If not set, the {@link DefaultLegendContent} component is used.
   * - If set to a React element, this element will be cloned and extra props will be passed in.
   * - If set to a function, the function will be called and should return HTML elements.
   *
   * @example <Legend content={CustomizedLegend} />
   * @example <Legend content={renderLegend} />
   */
      ~content: React.element=?,
      /**
   * CSS styles to be applied to the wrapper `div` element.
   */
      ~wrapperStyle: ReactDOM.Style.t=?,
      /**
   * Width of the legend.
   * Accept CSS style string values like `100%` or `fit-content`, or number values like `400`.
   */
      ~width: Dimension.t=?,
      /**
   * Height of the legend.
   * Accept CSS style string values like `100%` or `fit-content`, or number values like `400`.
   */
      ~height: Dimension.t=?,
      /**
   * If portal is defined, then Legend will use this element as a target
   * for rendering using React Portal.
   *
   * If this is undefined then Legend renders inside the recharts-wrapper element.
   *
   * @see {@link https://react.dev/reference/react-dom/createPortal}
   */
      ~portal: Dom.htmlElement=?,
      /**
   * Sorts Legend items. Defaults to `value` which means it will sort alphabetically
   * by the label.
   *
   * If `null` is provided then the payload is not sorted. Be aware that without sort,
   * the order of items may change between renders!
   *
   * @defaultValue value
   */
      ~itemSorter: LegendItemSorter.t<'payloadItem>=?,
      /**
   * The alignment of the whole Legend container:
   *
   * - `bottom`: shows the Legend below chart, and chart height reduces automatically to make space for it.
   * - `top`: shows the Legend above chart, and chart height reduces automatically.
   * - `middle`:  shows the Legend in the middle of chart, covering other content, and chart height remains unchanged.
   * The exact behavior changes depending on `align` prop.
   *
   * @defaultValue bottom
   */
      ~verticalAlign: VerticalAlignmentType.t=?,
    ) => React.element = "Legend"
  }

  module Bar = {
    @module("recharts") @react.component
    external make: (~dataKey: string, ~radius: float=?) => React.element = "Bar"
  }

  module BarChart = {
    @module("recharts") @react.component
    external make: (
      ~data: array<'data>,
      ~accessibilityLayer: bool=?,
      ~children: React.element,
    ) => React.element = "BarChart"
  }

  module GridLineType = {
    @unboxed
    type t =
      | @as(false) NoLine
      | Custom(React.element)
  }

  module CartesianGrid = {
    @module("recharts") @react.component
    external make: (~vertical: GridLineType.t=?, ~horizontal: GridLineType.t=?) => React.element =
      "CartesianGrid"
  }

  module XAxis = {
    @module("recharts") @react.component
    external make: (
      ~dataKey: string=?,
      ~tickLine: bool=?,
      ~axisLine: bool=?,
      ~tickMargin: int=?,
      ~tickFormatter: string => string=?,
    ) => React.element = "XAxis"
  }
}

module Style = {
  @react.component
  let make = (~id: string, ~config: chartConfig) => {
    let colorConfig =
      config
      ->Dict.toArray
      ->Array.filter(((_, itemConfig)) =>
        switch itemConfig {
        | {theme: _} | {color: _} => true
        | _ => false
        }
      )
    switch colorConfig {
    | [] => React.null
    | _ =>
      let css =
        [("light", ""), ("dark", ".dark")]
        ->Array.map(((themeName, prefix)) => {
          let declarations =
            colorConfig
            ->Array.filterMap(((key, itemConfig)) =>
              switch themeColor(~itemConfig, ~themeName) {
              | Some(color) => Some(`  --color-${key}: ${color};`)
              | None => None
              }
            )
            ->Array.join("\n")

          `${prefix} [data-chart=${id}] {\n${declarations}\n}`
        })
        ->Array.join("\n\n")
      <style
        dangerouslySetInnerHTML={(
          {
            "__html": css,
          }: {"__html": string}
        )}
      />
    }
  }
}

@react.component
let make = (
  ~config: chartConfig,
  ~className=?,
  ~children,
  ~id=?,
  ~style=?,
  ~onClick=?,
  ~onKeyDown=?,
) => {
  let uniqueId = React.useId()->String.replaceAll(":", "")
  let chartId = switch id {
  | Some(id) => `chart-${id}`
  | None => `chart-${uniqueId}`
  }
  module Provider = {
    let make = React.Context.provider(chartContext)
  }
  <Provider value={Some({config: config})}>
    <div
      ?id
      ?style
      ?onClick
      ?onKeyDown
      dataSlot="chart"
      dataChart={chartId}
      className={cn(
        "flex aspect-video justify-center text-xs [&_.recharts-cartesian-axis-tick_text]:fill-muted-foreground [&_.recharts-cartesian-grid_line[stroke='#ccc']]:stroke-border/50 [&_.recharts-curve.recharts-tooltip-cursor]:stroke-border [&_.recharts-dot[stroke='#fff']]:stroke-transparent [&_.recharts-layer]:outline-hidden [&_.recharts-polar-grid_[stroke='#ccc']]:stroke-border [&_.recharts-radial-bar-background-sector]:fill-muted [&_.recharts-rectangle.recharts-tooltip-cursor]:fill-muted [&_.recharts-reference-line_[stroke='#ccc']]:stroke-border [&_.recharts-sector]:outline-hidden [&_.recharts-sector[stroke='#fff']]:stroke-transparent [&_.recharts-surface]:outline-hidden",
        className,
      )}
    >
      <Style id={chartId} config={config} />
      <Recharts.ResponsiveContainer children />
    </div>
  </Provider>
}

module Tooltip = Recharts.Tooltip

module Indicator = {
  @unboxed
  type t =
    | @as("line") Line
    | @as("dot") Dot
    | @as("dashed") Dashed
}

module TooltipContent = {
  @react.component
  let make = (
    ~active=false,
    ~payload: array<payloadItem<'value>>=[],
    ~className=?,
    ~indicator=Indicator.Dot,
    ~hideLabel=false,
    ~hideIndicator=false,
    ~label=?,
    ~labelFormatter: option<(option<React.element>, array<payloadItem<'value>>) => React.element>=?,
    ~labelClassName=?,
    ~formatter: option<('value, string, payloadItem<'value>, int, dict<string>) => React.element>=?,
    ~color=?,
    ~nameKey=?,
    ~labelKey=?,
    ~id=?,
    ~style=?,
    ~onClick=?,
    ~onKeyDown=?,
  ) => {
    let {config} = use()

    let tooltipLabel = if hideLabel || payload->Array.length == 0 {
      None
    } else {
      switch payload->Array.get(0) {
      | None => None
      | Some(item) =>
        let key =
          labelKey->Option.orElse(item.dataKey)->Option.orElse(item.name)->Option.getOr("value")
        let itemConfig = getPayloadConfigFromPayload(~config, ~payload=item, ~key)
        let value = switch (labelKey, label) {
        | (None, Some(label)) =>
          switch config->Dict.get(label) {
          | Some(configItem) => Some(configItem.label->Option.getOr(label->React.string))
          | None => Some(label->React.string)
          }
        | _ => itemConfig->Option.flatMap(itemConfig => itemConfig.label)
        }
        switch labelFormatter {
        | Some(formatLabel) =>
          Some(
            <div className={cn("font-medium", labelClassName)}>
              {formatLabel(value, payload)}
            </div>,
          )
        | None =>
          switch value {
          | Some(value) => Some(<div className={cn("font-medium", labelClassName)}> {value} </div>)
          | None => None
          }
        }
      }
    }

    switch (active, payload) {
    | (false, _) | (_, []) => React.null
    | _ =>
      let nestLabel = payload->Array.length == 1 && indicator != Indicator.Dot
      let visiblePayloadItems = payload->Array.filter(item =>
        switch item.type_ {
        | Some("none") => false
        | _ => true
        }
      )

      <div
        ?id
        ?style
        ?onClick
        ?onKeyDown
        className={cn(
          "border-border/50 bg-background grid min-w-32 items-start gap-1.5 rounded-lg border px-2.5 py-1.5 text-xs shadow-xl",
          className,
        )}
      >
        {switch (nestLabel, tooltipLabel) {
        | (false, Some(labelElement)) => labelElement
        | _ => React.null
        }}
        <div className="grid gap-1.5">
          {visiblePayloadItems
          ->Array.mapWithIndex((item, index) => {
            let key =
              nameKey->Option.orElse(item.name)->Option.orElse(item.dataKey)->Option.getOr("value")
            let itemConfig = getPayloadConfigFromPayload(~config, ~payload=item, ~key)
            let indicatorColor =
              color->Option.orElse(item.payload->Dict.get("fill"))->Option.orElse(item.color)

            let customContent = switch (formatter, item.value, item.name) {
            | (Some(customFormatter), Some(value), Some(name)) =>
              Some(customFormatter(value, name, item, index, item.payload))
            | _ => None
            }
            let rawItemValue = item.value
            let itemValue = rawItemValue->Option.map(Float.toLocaleString)
            let shouldShowValue = rawItemValue->Option.isSome
            let itemLabel =
              itemConfig
              ->Option.flatMap(configItem => configItem.label)
              ->Option.orElse(item.name->Option.map(React.string))
            let itemKey =
              item.dataKey
              ->Option.orElse(item.name)
              ->Option.getOr(Int.toString(index))

            <div
              key={itemKey}
              className={`[&>svg]:text-muted-foreground flex w-full flex-wrap items-stretch gap-2 [&>svg]:h-2.5 [&>svg]:w-2.5 ${indicator ==
                  Indicator.Dot
                  ? "items-center"
                  : ""}`}
            >
              {switch customContent {
              | Some(content) => content
              | None =>
                <>
                  {switch itemConfig->Option.flatMap(itemConfig => itemConfig.icon) {
                  | Some(icon) => icon()
                  | None =>
                    hideIndicator
                      ? React.null
                      : {
                          let indicatorClass = switch indicator {
                          | Indicator.Dot => "h-2.5 w-2.5"
                          | Indicator.Line => "w-1"
                          | Indicator.Dashed =>
                            `w-0 border-[1.5px] border-dashed bg-transparent ${nestLabel
                                ? "my-0.5"
                                : ""}`
                          }
                          let indicatorStyle = indicatorColor->Option.map(color =>
                            ReactDOM.Style._dictToStyle(
                              dict{
                                "--color-bg": color,
                                "--color-border": color,
                              },
                            )
                          )
                          <div
                            style=?indicatorStyle
                            className={cn(
                              "shrink-0 rounded-[2px] border-(--color-border) bg-(--color-bg)",
                              indicatorClass->Some,
                            )}
                          />
                        }
                  }}
                  <div
                    className={`flex flex-1 justify-between leading-none ${nestLabel
                        ? "items-end"
                        : "items-center"}`}
                  >
                    <div className="grid gap-1.5">
                      {switch (nestLabel, tooltipLabel) {
                      | (true, Some(labelElement)) => labelElement
                      | _ => React.null
                      }}
                      {switch itemLabel {
                      | Some(itemLabel) =>
                        <span className="text-muted-foreground"> {itemLabel} </span>
                      | None => React.null
                      }}
                    </div>
                    {switch (shouldShowValue, itemValue) {
                    | (true, Some(itemValue)) =>
                      <span className="text-foreground font-mono font-medium tabular-nums">
                        {itemValue->React.string}
                      </span>
                    | _ => React.null
                    }}
                  </div>
                </>
              }}
            </div>
          })
          ->React.array}
        </div>
      </div>
    }
  }
}

module Legend = Recharts.Legend

module LegendContent = {
  @react.component
  let make = (
    ~className=?,
    ~hideIcon=false,
    ~payload: array<payloadItem<'value>>=[],
    ~verticalAlign="bottom",
    ~nameKey="",
    ~id=?,
    ~style=?,
    ~onClick=?,
    ~onKeyDown=?,
  ) => {
    let {config} = use()

    switch payload {
    | [] => React.null
    | _ =>
      <div
        ?id
        ?style
        ?onClick
        ?onKeyDown
        className={cn(
          `flex items-center justify-center gap-4 ${verticalAlign == "top" ? "pb-3" : "pt-3"}`,
          className,
        )}
      >
        {payload
        ->Array.filter(item =>
          switch item.type_ {
          | Some("none") => false
          | _ => true
          }
        )
        ->Array.mapWithIndex((item, index) => {
          let key = if nameKey != "" {
            nameKey
          } else {
            item.dataKey->Option.getOr("value")
          }
          let itemConfig = getPayloadConfigFromPayload(~config, ~payload=item, ~key)
          let itemKey = item.dataKey->Option.orElse(item.name)->Option.getOr(Int.toString(index))
          let colorStyle =
            item.color->Option.map(color =>
              ReactDOM.Style._dictToStyle(dict{"backgroundColor": color})
            )

          <div
            key={itemKey}
            className="[&>svg]:text-muted-foreground flex items-center gap-1.5 [&>svg]:h-3 [&>svg]:w-3"
          >
            {switch itemConfig->Option.flatMap(itemConfig => itemConfig.icon) {
            | Some(icon) =>
              hideIcon
                ? <div className="h-2 w-2 shrink-0 rounded-[2px]" style=?colorStyle />
                : icon()
            | None => <div className="h-2 w-2 shrink-0 rounded-[2px]" style=?colorStyle />
            }}
            {itemConfig->Option.flatMap(itemConfig => itemConfig.label)->Option.getOr(React.null)}
          </div>
        })
        ->React.array}
      </div>
    }
  }
}
