@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex w-full max-w-md flex-col gap-5">
    <Marker>
      <Marker.Content> {"A default marker"->React.string} </Marker.Content>
    </Marker>
    <Marker>
      <Marker.Icon>
        <Icons.FileText />
      </Marker.Icon>
      <Marker.Content> {"Opened implementation notes"->React.string} </Marker.Content>
    </Marker>
    <Marker role="status">
      <Marker.Icon>
        <Spinner />
      </Marker.Icon>
      <Marker.Content> {"Reading 4 files"->React.string} </Marker.Content>
    </Marker>
  </div>
