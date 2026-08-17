@@directive("'use client'")

module ChartDatum = {
  type t = {month: string, desktop: int, mobile: int}
}

module Recharts = {
  module BarChart = {
    type props = {
      accessibilityLayer?: bool,
      data: array<ChartDatum.t>,
      children?: React.element,
    }

    @module("recharts")
    external make: React.component<props> = "BarChart"
  }

  module Bar = {
    type props = {
      dataKey: string,
      fill: string,
      radius?: int,
    }

    @module("recharts")
    external make: React.component<props> = "Bar"
  }

  module CartesianGrid = {
    type props = {vertical?: bool}

    @module("recharts")
    external make: React.component<props> = "CartesianGrid"
  }

  module XAxis = {
    type props = {
      dataKey?: string,
      tickLine?: bool,
      axisLine?: bool,
      tickMargin?: int,
      tickFormatter?: string => string,
    }

    @module("recharts")
    external make: React.component<props> = "XAxis"
  }
}

let chartData: array<ChartDatum.t> = [
  {month: "January", desktop: 186, mobile: 80},
  {month: "February", desktop: 305, mobile: 200},
  {month: "March", desktop: 237, mobile: 120},
  {month: "April", desktop: 73, mobile: 190},
  {month: "May", desktop: 209, mobile: 130},
  {month: "June", desktop: 214, mobile: 140},
]

let chartConfig: Chart.ChartConfig.t = dict{
  "desktop": {color: "#2563eb"},
  "mobile": {color: "#60a5fa"},
}

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
      <Chart.Tooltip content={<Chart.TooltipContent />} />
      <Recharts.Bar dataKey="desktop" fill="var(--color-desktop)" radius={4} />
      <Recharts.Bar dataKey="mobile" fill="var(--color-mobile)" radius={4} />
    </Recharts.BarChart>
  </Chart>
