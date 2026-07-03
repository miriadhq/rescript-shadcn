@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex w-full max-w-md flex-col gap-5">
    <Marker role="status">
      <Marker.Icon>
        <Spinner />
      </Marker.Icon>
      <Marker.Content> {"Compacting conversation"->React.string} </Marker.Content>
    </Marker>
    <Marker role="status">
      <Marker.Content className="shimmer"> {"Thinking..."->React.string} </Marker.Content>
    </Marker>
    <Marker variant=Separator role="status">
      <Marker.Icon>
        <Spinner />
      </Marker.Icon>
      <Marker.Content> {"Loading earlier messages"->React.string} </Marker.Content>
    </Marker>
  </div>
