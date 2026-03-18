@@directive("'use client'")

module DemoCard = {
  @react.component
  let make = (~children) => {
    <div className="flex items-center justify-center min-h-[400px] relative rounded-lg border p-4">
      {children}
    </div>
  }
}

@react.component
let make = () => {
  <div className="flex flex-col gap-4">
    <DemoCard>
      <AccordionDemo />
    </DemoCard>
    <DemoCard>
      <CardDemo />
    </DemoCard>
  </div>
}
