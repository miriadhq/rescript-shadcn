@@directive("'use client'")

type chartDatum = {month: string, desktop: int, mobile: int}

module Recharts = {
  type barChartProps = {
    accessibilityLayer?: bool,
    data: array<chartDatum>,
    children?: React.element,
  }

  module BarChart = {
    @module("recharts")
    external make: React.component<barChartProps> = "BarChart"
  }

  type barProps = {
    dataKey: string,
    fill: string,
    radius?: int,
  }

  module Bar = {
    @module("recharts")
    external make: React.component<barProps> = "Bar"
  }

  type cartesianGridProps = {
    vertical?: bool,
    orientation?: string,
  }

  module CartesianGrid = {
    @module("recharts")
    external make: React.component<cartesianGridProps> = "CartesianGrid"
  }

  type xAxisProps = {
    dataKey?: string,
    tickLine?: bool,
    axisLine?: bool,
    tickMargin?: int,
    tickFormatter?: string => string,
    reversed?: bool,
  }

  module XAxis = {
    @module("recharts")
    external make: React.component<xAxisProps> = "XAxis"
  }
}

let chartData = [
  {month: "january", desktop: 186, mobile: 80},
  {month: "february", desktop: 305, mobile: 200},
  {month: "march", desktop: 237, mobile: 120},
  {month: "april", desktop: 73, mobile: 190},
  {month: "may", desktop: 209, mobile: 130},
  {month: "june", desktop: 214, mobile: 140},
]

let monthsAr = Dict.fromArray([
  ("january", "يناير"),
  ("february", "فبراير"),
  ("march", "مارس"),
  ("april", "أبريل"),
  ("may", "مايو"),
  ("june", "يونيو"),
])

let chartConfig: Chart.chartConfig = Dict.fromArray([
  ("desktop", ({color: "var(--chart-2)"}: Chart.chartConfigItem)),
  ("mobile", ({color: "var(--chart-1)"}: Chart.chartConfigItem)),
])

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Chart config={chartConfig} className="min-h-[200px] w-full">
    <Recharts.BarChart accessibilityLayer={true} data={chartData}>
      <Recharts.CartesianGrid vertical={false} orientation="right" />
      <Recharts.XAxis
        dataKey="month"
        tickLine={false}
        tickMargin={10}
        axisLine={false}
        tickFormatter={value =>
          monthsAr->Dict.get(value)->Option.getOr(value)->String.slice(~start=0, ~end=3)}
        reversed={true}
      />
      <Chart.Tooltip content={<Chart.TooltipContent />} />
      <Chart.Legend content={<Chart.LegendContent />} />
      <Recharts.Bar dataKey="desktop" fill="var(--color-desktop)" radius={4} />
      <Recharts.Bar dataKey="mobile" fill="var(--color-mobile)" radius={4} />
    </Recharts.BarChart>
  </Chart>
