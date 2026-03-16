@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex items-center gap-4">
    <Icons.Loader role="status" ariaLabel="Loading" className="size-4 animate-spin" />
  </div>
