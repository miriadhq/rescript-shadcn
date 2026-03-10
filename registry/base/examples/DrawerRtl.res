@@directive("'use client'")

@send external toLocaleString: (int, string) => string = "toLocaleString"

type drawerDatum = {goal: int}

module Recharts = {
  type responsiveContainerProps = {
    width: string,
    height: string,
    children: React.element,
  }

  module ResponsiveContainer = {
    @module("recharts")
    external make: React.component<responsiveContainerProps> = "ResponsiveContainer"
  }

  type barChartProps = {
    data: array<drawerDatum>,
    children: React.element,
  }

  module BarChart = {
    @module("recharts")
    external make: React.component<barChartProps> = "BarChart"
  }

  type barProps = {
    dataKey: string,
    style?: ReactDOM.Style.t,
  }

  module Bar = {
    @module("recharts")
    external make: React.component<barProps> = "Bar"
  }

  type xAxisProps = {
    dataKey: string,
    tickLine: bool,
    tickMargin: int,
    axisLine: bool,
    reversed?: bool,
    tickFormatter?: int => string,
  }

  module XAxis = {
    @module("recharts")
    external make: React.component<xAxisProps> = "XAxis"
  }
}

let data: array<drawerDatum> = [
  {goal: 400},
  {goal: 300},
  {goal: 200},
  {goal: 300},
  {goal: 200},
  {goal: 278},
  {goal: 189},
  {goal: 239},
  {goal: 300},
  {goal: 200},
  {goal: 278},
  {goal: 189},
  {goal: 349},
]

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (goal, setGoal) = React.useState(() => 350)

  let onClick = adjustment =>
    setGoal(prev => Math.Int.max(200, Math.Int.min(400, prev + adjustment)))

  <Drawer>
    <Drawer.Trigger asChild={true}>
      <Button variant=Button.Variant.Outline dataSlot="drawer-trigger">
        {"فتح الدرج"->React.string}
      </Button>
    </Drawer.Trigger>
    <Drawer.Content dir="rtl" dataLang="ar">
      <div className="mx-auto w-full max-w-sm">
        <Drawer.Header>
          <Drawer.Title> {"نقل الهدف"->React.string} </Drawer.Title>
          <Drawer.Description>
            {"حدد هدف نشاطك اليومي."->React.string}
          </Drawer.Description>
        </Drawer.Header>
        <div className="p-4 pb-0">
          <div className="flex items-center justify-center space-x-2">
            <Button
              variant=Button.Variant.Outline
              size=Button.Size.Icon
              className="h-8 w-8 shrink-0 rounded-full"
              onClick={_ => onClick(-10)}
              disabled={goal <= 200}
            >
              <Icons.Minus />
              <span className="sr-only"> {"تقليل"->React.string} </span>
            </Button>
            <div className="flex-1 text-center">
              <div className="text-7xl font-bold tracking-tighter">
                {goal->toLocaleString("ar-EG")->React.string}
              </div>
              <div className="text-muted-foreground text-[0.70rem] uppercase">
                {"سعرات حرارية/يوم"->React.string}
              </div>
            </div>
            <Button
              variant=Button.Variant.Outline
              size=Button.Size.Icon
              className="h-8 w-8 shrink-0 rounded-full"
              onClick={_ => onClick(10)}
              disabled={goal >= 400}
            >
              <Icons.Plus />
              <span className="sr-only"> {"زيادة"->React.string} </span>
            </Button>
          </div>
          <div className="mt-3 h-[120px]">
            <Recharts.ResponsiveContainer width="100%" height="100%">
              <Recharts.BarChart data>
                <Recharts.XAxis
                  dataKey="goal"
                  tickLine={false}
                  tickMargin={10}
                  axisLine={false}
                  reversed={true}
                  tickFormatter={v => v->toLocaleString("ar-EG")}
                />
                <Recharts.Bar dataKey="goal" style={{fill: "var(--chart-2)"}} />
              </Recharts.BarChart>
            </Recharts.ResponsiveContainer>
          </div>
        </div>
        <Drawer.Footer>
          <Button> {"إرسال"->React.string} </Button>
          <Drawer.Close asChild={true}>
            <Button variant=Button.Variant.Outline> {"إلغاء"->React.string} </Button>
          </Drawer.Close>
        </Drawer.Footer>
      </div>
    </Drawer.Content>
  </Drawer>
}
