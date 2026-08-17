@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex w-full max-w-sm flex-col gap-3 py-12">
    <Marker variant=Border>
      <Marker.Icon>
        <Icons.GitBranch />
      </Marker.Icon>
      <Marker.Content> {"Switched to release-candidate"->React.string} </Marker.Content>
    </Marker>
    <Marker variant=Border>
      <Marker.Icon>
        <Icons.Search />
      </Marker.Icon>
      <Marker.Content> {"Reviewed 8 related files"->React.string} </Marker.Content>
    </Marker>
    <Marker variant=Border>
      <Marker.Icon>
        <Icons.FileText />
      </Marker.Icon>
      <Marker.Content> {"Opened implementation notes"->React.string} </Marker.Content>
    </Marker>
  </div>
