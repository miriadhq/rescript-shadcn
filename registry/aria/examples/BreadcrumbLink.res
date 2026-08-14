external renderAnchor: (string, ReactAria.Button.Link.renderProps) => React.element =
  "createElement"

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Breadcrumb>
    <Breadcrumb.List>
      <Breadcrumb.Item>
        <Breadcrumb.Link
          href="#link-component"
          render={props => renderAnchor("a", props)}
        >
          {"Home"->React.string}
        </Breadcrumb.Link>
      </Breadcrumb.Item>
      <Breadcrumb.Item>
        <Breadcrumb.Link
          href="#link-component"
          render={props => renderAnchor("a", props)}
        >
          {"Components"->React.string}
        </Breadcrumb.Link>
      </Breadcrumb.Item>
      <Breadcrumb.Item>
        <Breadcrumb.Page> {"Breadcrumb"->React.string} </Breadcrumb.Page>
      </Breadcrumb.Item>
    </Breadcrumb.List>
  </Breadcrumb>
