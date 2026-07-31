@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex w-full max-w-md flex-col gap-6">
    <Marker>
      <Marker.Content> {"Default marker"->React.string} </Marker.Content>
    </Marker>
    <Marker variant=Border>
      <Marker.Icon>
        <Icons.Archive />
      </Marker.Icon>
      <Marker.Content> {"Switched to release-candidate"->React.string} </Marker.Content>
    </Marker>
    <Marker variant=Separator>
      <Marker.Content> {"Today"->React.string} </Marker.Content>
    </Marker>
  </div>
