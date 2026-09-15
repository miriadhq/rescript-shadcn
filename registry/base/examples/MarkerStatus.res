@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex w-full max-w-sm flex-col gap-8 py-12">
    <Marker role="status">
      <Marker.Icon>
        <Spinner />
      </Marker.Icon>
      <Marker.Content> {"Compacting conversation"->React.string} </Marker.Content>
    </Marker>
    <Marker variant=Separator role="status">
      <Marker.Icon>
        <Spinner />
      </Marker.Icon>
      <Marker.Content> {"Running tests"->React.string} </Marker.Content>
    </Marker>
  </div>
