@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

// ComponentPreview: async server component that renders a demo with source code tabs.
// Names in MDX are PascalCase matching the ReScript module name (e.g. "ButtonDemo").

module Type = {
  type t =
    | @as("block") Block
    | @as("component") Component
    | @as("example") Example
}

@react.component
let make = async (
  ~name,
  ~\"type" as type_: option<Type.t>=?,
  ~className=?,
  ~previewClassName=?,
  ~align=ComponentPreviewTabs.Align.Center,
  ~hideCode=false,
  ~chromeLessOnMobile=false,
  ~direction=BaseUi.Types.TextDirection.Ltr,
  ~caption=?,
) => {
  switch name {
  | None => React.null
  | Some(name) =>
    // Block type: render images + iframe instead of inline component
    switch type_ {
    | Some(Type.Block) =>
      // Render block components inline in a contained wrapper.
      // `transform: scale(1)` creates a new containing block so that
      // position:fixed children (e.g. Sidebar) are trapped inside.
      let componentElement = <DemoLoader name />
      let content =
        <div
          className="relative mt-6 aspect-[4/2.5] w-full overflow-hidden rounded-xl border"
          style={{transform: "scale(1)"}}
        >
          <div className="absolute inset-0 bg-background"> {componentElement} </div>
        </div>

      switch caption {
      | Some(caption) =>
        <figure className="flex flex-col gap-4">
          content
          <figcaption className="text-center text-sm text-muted-foreground">
            {caption->React.string}
          </figcaption>
        </figure>
      | None => content
      }
    | Some(Component | Example) | None =>
      // Render demo client-side via DemoLoader (avoids RSC client reference issues
      // with nested submodule access like Accordion.Item.make)
      let componentElement = <DemoLoader name />

      // Get component name for source lookup
      let componentName = name

      // Get source code (full and preview)
      let source = <ComponentSource name={componentName} collapsible=false />
      let sourcePreview = <ComponentSource name={componentName} collapsible=false maxLines=3 />

      let content =
        <ComponentPreviewTabs
          ?className
          ?previewClassName
          align
          hideCode
          chromeLessOnMobile
          component={componentElement}
          source
          sourcePreview
          direction
        />

      switch caption {
      | Some(caption) =>
        <figure dataHideCode={hideCode} className="flex flex-col data-[hide-code=true]:gap-4">
          content
          <figcaption
            className="-mt-8 text-center text-sm text-muted-foreground data-[hide-code=true]:mt-0"
          >
            {caption->React.string}
          </figcaption>
        </figure>
      | None => content
      }
    }
  }
}
