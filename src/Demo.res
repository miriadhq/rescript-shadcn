@@directive("'use client'")

@react.component
let make = () => {
  <div className="flex flex-col gap-4 border rounded-lg p-4 min-h-[450px] relative">
    <div className="flex items-center justify-between">
      <h2 className="text-sm text-muted-foreground sm:pl-3">
        {"A complex component showing hooks, libs and components."->React.string}
      </h2>
      <OpenInV0Button name="accordion-demo" className="w-fit" />
    </div>
    <div className="flex items-center justify-center min-h-[400px] relative">
      <AccordionDemo />
    </div>
  </div>
}
