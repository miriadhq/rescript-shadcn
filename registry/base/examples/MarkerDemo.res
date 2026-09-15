module GitBranchIcon = {
  @module("lucide-react") external make: React.component<Icons.props> = "GitBranchIcon"
}

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex w-full max-w-sm flex-col gap-8 py-12">
    <Marker>
      <Marker.Icon>
        <GitBranchIcon />
      </Marker.Icon>
      <Marker.Content> {"Switched to a new branch"->React.string} </Marker.Content>
    </Marker>
    <Marker role="status">
      <Marker.Icon>
        <Spinner />
      </Marker.Icon>
      <Marker.Content className="shimmer"> {"Thinking..."->React.string} </Marker.Content>
    </Marker>
    <Marker variant=Separator>
      <Marker.Content> {"Conversation compacted"->React.string} </Marker.Content>
    </Marker>
    <Marker>
      <Marker.Icon>
        <Icons.Search />
      </Marker.Icon>
      <Marker.Content> {"Explored 4 files"->React.string} </Marker.Content>
    </Marker>
  </div>
