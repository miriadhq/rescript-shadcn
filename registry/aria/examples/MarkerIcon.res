@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex w-full max-w-sm flex-col gap-12 py-12">
    <Marker>
      <Marker.Icon>
        <Icons.GitBranch />
      </Marker.Icon>
      <Marker.Content> {"Switched to a new branch"->React.string} </Marker.Content>
    </Marker>
    <Marker variant=Separator>
      <Marker.Icon>
        <Icons.Search />
      </Marker.Icon>
      <Marker.Content> {"Explored 4 files"->React.string} </Marker.Content>
    </Marker>
    <Marker className="flex-col">
      <Marker.Icon>
        <Icons.BookOpenCheck />
      </Marker.Icon>
      <Marker.Content> {"Syncing completed"->React.string} </Marker.Content>
    </Marker>
  </div>
