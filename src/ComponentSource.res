@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

let registryRoot = Node.Path.join([Node.cwd(), "registry", "base"])

let fileExists = async (filePath: string) => {
  try {
    await Node.Fs.access(filePath)
    true
  } catch {
  | _ => false
  }
}

let resolveSourcePath = async (name: string) => {
  // Try examples first (e.g., "ButtonDemo" -> registry/base/examples/ButtonDemo.res)
  let examplePath = Node.Path.join([registryRoot, "examples", `${name}.res`])
  if await fileExists(examplePath) {
    Some(examplePath)
  } else {
    // Try UI component (e.g., "Button" -> registry/base/ui/Button.res)
    let uiPath = Node.Path.join([registryRoot, "ui", `${name}.res`])
    if await fileExists(uiPath) {
      Some(uiPath)
    } else {
      None
    }
  }
}

module ComponentCode = {
  @react.component
  let make = (~code, ~highlightedCode, ~language, ~title=?) => {
    <figure dataRehypePrettyCodeFigure="" className="[&>pre]:max-h-96">
      {switch title {
      | None => React.null
      | Some(title) =>
        <figcaption
          dataRehypePrettyCodeTitle=""
          className="flex items-center gap-2 text-code-foreground [&_svg]:size-4 [&_svg]:text-code-foreground [&_svg]:opacity-70"
          dataLanguage={language}
        >
          {BrandIcons.getIconForLanguageExtension(language)}
          {title->React.string}
        </figcaption>
      }}
      <CopyButton value={code} />
      <div dangerouslySetInnerHTML={{"__html": highlightedCode}} />
    </figure>
  }
}

@react.component
let make = async (
  ~name=?,
  ~src=?,
  ~title=?,
  ~language=?,
  ~collapsible=true,
  ~className=?,
  ~maxLines=?,
) => {
  let code = switch (name, src) {
  | (None, None) => None
  | (_, Some(src)) => {
      // src is always relative to registry/base (e.g., "/registry/base/examples/Foo.res")
      let relativePath = src->String.replace("/registry/base/", "")
      (await Node.Fs.readFile(Node.Path.join([registryRoot, relativePath]), "utf-8"))->Some
    }
  | (Some(name), None) =>
    switch await resolveSourcePath(name) {
    | Some(path) => (await Node.Fs.readFile(path, "utf-8"))->Some
    | None => None
    }
  }

  switch code {
  | None => React.null
  | Some(rawCode) =>
    let rawCode =
      rawCode->String.replaceAll("@react.componentWithProps(Demo.Props.t)", "@react.component")
    let rawCode = rawCode->String.replaceAll("({}: Demo.Props.t)", "()")
    let code = switch maxLines {
    | Some(ml) => rawCode->String.split("\n")->Array.slice(~start=0, ~end=ml)->Array.join("\n")
    | None => rawCode
    }

    let language =
      language
      ->Option.orElse(title->Option.flatMap(t => String.split(t, ".")->Array.pop))
      ->Option.getOr("rescript")

    let highlightedCode = await HighlightCode.highlightCode(code, ~language)

    let codeEl = <ComponentCode code highlightedCode language ?title />

    if !collapsible {
      <div className={Commons.cn("relative", className)}> codeEl </div>
    } else {
      <CodeCollapsibleWrapper className=?className> codeEl </CodeCollapsibleWrapper>
    }
  }
}
