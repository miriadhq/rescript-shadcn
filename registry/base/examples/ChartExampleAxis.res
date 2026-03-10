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

  type cartesianGridProps = {vertical?: bool}

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
  }

  module XAxis = {
    @module("recharts")
    external make: React.component<xAxisProps> = "XAxis"
  }
}

let chartData = [
  {month: "January", desktop: 186, mobile: 80},
  {month: "February", desktop: 305, mobile: 200},
  {month: "March", desktop: 237, mobile: 120},
  {month: "April", desktop: 73, mobile: 190},
  {month: "May", desktop: 209, mobile: 130},
  {month: "June", desktop: 214, mobile: 140},
]

let chartConfig: Chart.chartConfig = Dict.fromArray([
  ("desktop", ({color: "#2563eb"}: Chart.chartConfigItem)),
  ("mobile", ({color: "#60a5fa"}: Chart.chartConfigItem)),
])

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Chart config={chartConfig} className="min-h-[200px] w-full">
    <Recharts.BarChart accessibilityLayer={true} data={chartData}>
      <Recharts.CartesianGrid vertical={false} />
      <Recharts.XAxis
        dataKey="month"
        tickLine={false}
        tickMargin={10}
        axisLine={false}
        tickFormatter={value => value->String.slice(~start=0, ~end=3)}
      />
      <Recharts.Bar dataKey="desktop" fill="var(--color-desktop)" radius={4} />
      <Recharts.Bar dataKey="mobile" fill="var(--color-mobile)" radius={4} />
    </Recharts.BarChart>
  </Chart>
