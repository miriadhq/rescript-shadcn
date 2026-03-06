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

type props = {
  name?: string,
  className?: string,
  previewClassName?: string,
  align?: string,
  hideCode?: bool,
  styleName?: string,
  caption?: string,
}

let make = async (props: props) => {
  let name = props.name->Option.getOr("")
  if name === "" {
    React.null
  } else {
    let align = props.align->Option.getOr("center")
    let hideCode = props.hideCode->Option.getOr(false)
    let styleName = props.styleName->Option.getOr("base-v0")

    // Render demo client-side via DemoRenderer (avoids RSC client reference issues
    // with nested submodule access like Accordion.Item.make)
    let componentElement = <DemoRenderer name />

    // Get component name for source lookup
    let componentName = getComponentName(name)

    // Get source code (full and preview)
    let source = await ComponentSource.make({name: componentName, collapsible: false, styleName})
    let sourcePreview = await ComponentSource.make({
      name: componentName,
      collapsible: false,
      styleName,
      maxLines: 3,
    })

    let content =
      <ComponentPreviewTabs
        className=?{props.className}
        previewClassName=?{props.previewClassName}
        align
        hideCode
        component={componentElement}
        source
        sourcePreview
      />

    switch props.caption {
    | Some(caption) =>
      <figure className="flex flex-col gap-4">
        content
        <figcaption className="text-muted-foreground text-center text-sm">
          {caption->React.string}
        </figcaption>
      </figure>
    | None => content
    }
  }
}
