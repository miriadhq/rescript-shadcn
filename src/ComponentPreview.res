@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

// ComponentPreview: async server component that renders a demo with source code tabs.
// Names in MDX are PascalCase matching the ReScript module name (e.g. "ButtonDemo").

// Extract base component name: "ButtonDemo" -> "Button", "ButtonSize" -> "Button"
let getComponentName = (name: string) => {
  // Common suffixes to strip
  let suffixes = [
    "Demo",
    "Basic",
    "Default",
    "Size",
    "Outline",
    "Secondary",
    "Ghost",
    "Destructive",
    "Link",
    "Icon",
    "WithIcon",
    "Rounded",
    "Spinner",
    "Render",
    "Rtl",
  ]
  let result = ref(name)
  suffixes->Array.forEach(suffix => {
    if name->String.endsWith(suffix) && name !== suffix {
      let candidate = name->String.slice(~start=0, ~end=name->String.length - suffix->String.length)
      if candidate->String.length > 0 {
        result := candidate
      }
    }
  })
  result.contents
}

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
      let content =
        <div
          className="relative mt-6 aspect-[4/2.5] w-full overflow-hidden rounded-xl border md:-mx-1"
        >
          <Next.Image
            src={`/r/styles/new-york-v4/${name}-light.png`}
            alt={name}
            width=1440
            height=900
            className="absolute top-0 left-0 z-20 w-[970px] max-w-none bg-background sm:w-[1280px] md:hidden dark:hidden md:dark:hidden"
          />
          <Next.Image
            src={`/r/styles/new-york-v4/${name}-dark.png`}
            alt={name}
            width=1440
            height=900
            className="absolute top-0 left-0 z-20 hidden w-[970px] max-w-none bg-background sm:w-[1280px] md:hidden dark:block md:dark:hidden"
          />
          <div className="absolute inset-0 hidden w-[1600px] bg-background md:block">
            <iframe src={`/view/${name}`} className="size-full" />
          </div>
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
      let componentName = getComponentName(name)

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
