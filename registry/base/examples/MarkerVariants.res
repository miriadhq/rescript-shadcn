@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex w-full max-w-sm flex-col gap-8 py-12">
    <Marker>
      <Marker.Content> {"A default marker for inline notes."->React.string} </Marker.Content>
    </Marker>
    <Marker variant=Separator>
      <Marker.Content> {"A separator marker"->React.string} </Marker.Content>
    </Marker>
    <Marker variant=Border>
      <Marker.Content> {"A border marker for row boundaries."->React.string} </Marker.Content>
    </Marker>
  </div>
