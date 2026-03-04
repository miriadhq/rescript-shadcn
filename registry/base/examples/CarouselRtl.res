@@directive("'use client'")

@react.component
let make = () =>
  <Carousel dir="rtl" className="w-full max-w-[12rem] sm:max-w-xs" opts={{direction: "rtl"}}>
    <Carousel.Content>
      {Array.fromInitializer(~length=5, index =>
        <Carousel.Item key={Int.toString(index)}>
          <div className="p-1">
            <Card>
              <Card.Content className="flex aspect-square items-center justify-center p-6">
                <span className="text-4xl font-semibold">
                  {Int.toString(index + 1)->React.string}
                </span>
              </Card.Content>
            </Card>
          </div>
        </Carousel.Item>
      )->React.array}
    </Carousel.Content>
    <Carousel.Previous />
    <Carousel.Next />
  </Carousel>
