@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex w-full max-w-sm flex-col gap-4">
    <Marker role="status">
      <Marker.Icon>
        <Spinner />
      </Marker.Icon>
      <Marker.Content className="shimmer"> {"Thinking..."->React.string} </Marker.Content>
    </Marker>
    <Marker variant=Separator role="status">
      <Marker.Content className="shimmer"> {"Reading 4 files"->React.string} </Marker.Content>
    </Marker>
  </div>
