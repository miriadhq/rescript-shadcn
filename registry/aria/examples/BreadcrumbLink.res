@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

module NextLink = {
  @module("next/link")
  external make: React.component<ReactAria.Button.Link.RenderProps.t> = "default"
}

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Breadcrumb>
    <Breadcrumb.List>
      <Breadcrumb.Item>
        <Breadcrumb.Link
          href="#link-component"
          render={props =>
            props.href->Option.isSome ? <NextLink {...props} /> : <span {...props} />}
        >
          {"Home"->React.string}
        </Breadcrumb.Link>
      </Breadcrumb.Item>
      <Breadcrumb.Item>
        <Breadcrumb.Link
          href="#link-component"
          render={props =>
            props.href->Option.isSome ? <NextLink {...props} /> : <span {...props} />}
        >
          {"Components"->React.string}
        </Breadcrumb.Link>
      </Breadcrumb.Item>
      <Breadcrumb.Item>
        <Breadcrumb.Page> {"Breadcrumb"->React.string} </Breadcrumb.Page>
      </Breadcrumb.Item>
    </Breadcrumb.List>
  </Breadcrumb>
