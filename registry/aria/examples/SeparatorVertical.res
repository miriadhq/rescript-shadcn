@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex h-5 items-center gap-4 text-sm">
    <div> {"Blog"->React.string} </div>
    <Separator orientation=Vertical />
    <div> {"Docs"->React.string} </div>
    <Separator orientation=Vertical />
    <div> {"Source"->React.string} </div>
  </div>
