@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex w-full max-w-sm flex-col gap-8 py-12">
    <Marker variant=Separator>
      <Marker.Content> {"Today"->React.string} </Marker.Content>
    </Marker>
    <Marker variant=Separator>
      <Marker.Content> {"Worked for 42s"->React.string} </Marker.Content>
    </Marker>
    <Marker variant=Separator>
      <Marker.Content> {"Conversation compacted"->React.string} </Marker.Content>
    </Marker>
  </div>
