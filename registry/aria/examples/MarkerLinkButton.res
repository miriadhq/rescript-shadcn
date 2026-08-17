@@directive("'use client'")

@module("sonner") external toast: string => unit = "toast"
@module("react")
external createElement: (string, ReactAria.Types.DomProps.t) => React.element = "createElement"

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex w-full max-w-sm flex-col gap-8 py-12">
    <Marker render={props => createElement("a", {...props, href: "#links-and-buttons"})}>
      <Marker.Icon>
        <Icons.GitBranch />
      </Marker.Icon>
      <Marker.Content> {"View the pull request"->React.string} </Marker.Content>
    </Marker>
    <Marker
      className="transition-colors hover:text-foreground"
      render={props =>
        createElement(
          "button",
          {
            ...props,
            type_: "button",
            onClick: _ => toast("You clicked the revert button"),
          },
        )}
    >
      <Marker.Icon>
        <Icons.RotateCcw />
      </Marker.Icon>
      <Marker.Content> {"Revert this change"->React.string} </Marker.Content>
    </Marker>
  </div>
