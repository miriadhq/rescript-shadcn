@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

@@directive("'use client'")

type chartDatum = {
  date: string,
  desktop: int,
  mobile: int,
}

module Recharts = {
  type margin = {left: int, right: int}

  type barChartProps = {
    accessibilityLayer?: bool,
    data: array<chartDatum>,
    margin: margin,
    children: React.element,
  }

  module BarChart = {
    @module("recharts")
    external make: React.component<barChartProps> = "BarChart"
  }

  type barProps = {
    dataKey: string,
    fill: string,
  }

  module Bar = {
    @module("recharts")
    external make: React.component<barProps> = "Bar"
  }

  type cartesianGridProps = {vertical: bool}

  module CartesianGrid = {
    @module("recharts")
    external make: React.component<cartesianGridProps> = "CartesianGrid"
  }

  type xAxisProps = {
    dataKey: string,
    tickLine: bool,
    axisLine: bool,
    tickMargin: int,
    minTickGap: int,
    tickFormatter?: string => string,
  }

  module XAxis = {
    @module("recharts")
    external make: React.component<xAxisProps> = "XAxis"
  }
}

let chartData: array<chartDatum> = [
  {date: "2024-04-01", desktop: 222, mobile: 150},
  {date: "2024-04-02", desktop: 97, mobile: 180},
  {date: "2024-04-03", desktop: 167, mobile: 120},
  {date: "2024-04-04", desktop: 242, mobile: 260},
  {date: "2024-04-05", desktop: 373, mobile: 290},
  {date: "2024-04-06", desktop: 301, mobile: 340},
  {date: "2024-04-07", desktop: 245, mobile: 180},
  {date: "2024-04-08", desktop: 409, mobile: 320},
  {date: "2024-04-09", desktop: 59, mobile: 110},
  {date: "2024-04-10", desktop: 261, mobile: 190},
  {date: "2024-04-11", desktop: 327, mobile: 350},
  {date: "2024-04-12", desktop: 292, mobile: 210},
  {date: "2024-04-13", desktop: 342, mobile: 380},
  {date: "2024-04-14", desktop: 137, mobile: 220},
  {date: "2024-04-15", desktop: 120, mobile: 170},
  {date: "2024-04-16", desktop: 138, mobile: 190},
  {date: "2024-04-17", desktop: 446, mobile: 360},
  {date: "2024-04-18", desktop: 364, mobile: 410},
  {date: "2024-04-19", desktop: 243, mobile: 180},
  {date: "2024-04-20", desktop: 89, mobile: 150},
  {date: "2024-04-21", desktop: 137, mobile: 200},
  {date: "2024-04-22", desktop: 224, mobile: 170},
  {date: "2024-04-23", desktop: 138, mobile: 230},
  {date: "2024-04-24", desktop: 387, mobile: 290},
  {date: "2024-04-25", desktop: 215, mobile: 250},
  {date: "2024-04-26", desktop: 75, mobile: 130},
  {date: "2024-04-27", desktop: 383, mobile: 420},
  {date: "2024-04-28", desktop: 122, mobile: 180},
  {date: "2024-04-29", desktop: 315, mobile: 240},
  {date: "2024-04-30", desktop: 454, mobile: 380},
]

let chartConfig: Chart.chartConfig = dict{
  "views": {label: React.string("Page Views")},
  "desktop": {label: React.string("Desktop"), color: "var(--chart-2)"},
  "mobile": {label: React.string("Mobile"), color: "var(--chart-1)"},
}

let desktopTotal = chartData->Array.reduce(0, (total, datum) => total + datum.desktop)
let mobileTotal = chartData->Array.reduce(0, (total, datum) => total + datum.mobile)

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (activeChart, setActiveChart) = React.useState(() => "desktop")

  <Card className="py-0 pb-4">
    <Card.Header className="flex flex-col items-stretch border-b p-0! sm:flex-row">
      <div className="flex flex-1 flex-col justify-center gap-1 px-6 pt-4 pb-3 sm:py-0!">
        <Card.Title> {React.string("Bar Chart - Interactive")} </Card.Title>
        <Card.Description>
          {React.string("Showing total visitors for the last 3 months")}
        </Card.Description>
      </div>
      <div className="flex">
        {["desktop", "mobile"]
        ->Array.map(chart =>
          <button
            key=chart
            dataActive={activeChart == chart}
            className="relative z-30 flex flex-1 flex-col justify-center gap-1 border-t px-6 py-4 text-left even:border-l data-[active=true]:bg-muted/50 sm:border-t-0 sm:border-l sm:px-8 sm:py-6"
            onClick={_ => setActiveChart(_ => chart)}
          >
            <span className="text-xs text-muted-foreground">
              {React.string(chart == "desktop" ? "Desktop" : "Mobile")}
            </span>
            <span className="text-lg leading-none font-bold sm:text-3xl">
              {(chart == "desktop" ? desktopTotal : mobileTotal)->Int.toLocaleString->React.string}
            </span>
          </button>
        )
        ->React.array}
      </div>
    </Card.Header>
    <Card.Content className="px-2 sm:p-6">
      <Chart config=chartConfig className="aspect-auto h-[250px] w-full">
        <Recharts.BarChart accessibilityLayer=true data=chartData margin={{left: 12, right: 12}}>
          <Recharts.CartesianGrid vertical=false />
          <Recharts.XAxis
            dataKey="date"
            tickLine=false
            axisLine=false
            tickMargin=8
            minTickGap=32
            tickFormatter={value =>
              value
              ->Date.fromString
              ->Date.toLocaleDateStringWithLocaleAndOptions(
                "en-US",
                {month: #short, day: #numeric},
              )}
          />
          <Chart.Tooltip
            content={<Chart.TooltipContent
              className="w-[150px]"
              nameKey="views"
              labelFormatter={(_, payload) =>
                payload
                ->Array.get(0)
                ->Option.flatMap(item => item.Chart.payload->Dict.get("date"))
                ->Option.map(value =>
                  value
                  ->Date.fromString
                  ->Date.toLocaleDateStringWithLocaleAndOptions(
                    "en-US",
                    {month: #short, day: #numeric, year: #numeric},
                  )
                  ->React.string
                )
                ->Option.getOr(React.null)}
            />}
          />
          <Recharts.Bar dataKey=activeChart fill={`var(--color-${activeChart})`} />
        </Recharts.BarChart>
      </Chart>
    </Card.Content>
  </Card>
}
