@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

module Kind = {
  type t =
    | Example
    | Component
}

let registryRoot = lib => Node.Path.join([Node.cwd(), "registry", lib->Config.Lib.toString])

@module("./lib/format-code.mjs")
external formatCode: (string, Config.Style.t) => promise<string> = "formatCode"

let fileExists = async (filePath: string) => {
  try {
    await Node.Fs.access(filePath)
    true
  } catch {
  | _ => false
  }
}

let resolveSourcePath = async (name: string, kind, lib) => {
  let examplePath = Node.Path.join([
    registryRoot(lib),
    switch kind {
    | Kind.Example => "examples"
    | Kind.Component => "ui"
    },
    `${name}.res`,
  ])
  await fileExists(examplePath) ? Some(examplePath) : None
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
      <div dangerouslySetInnerHTML={{"__html": highlightedCode}->Obj.magic} />
    </figure>
  }
}

module RenderCode = {
  @react.component
  let make = async (
    ~rawCode,
    ~style,
    ~title=?,
    ~language=?,
    ~collapsible=true,
    ~className=?,
    ~maxLines=?,
  ) => {
    let rawCode =
      rawCode->String.replaceAll("@react.componentWithProps(Demo.Props.t)", "@react.component")
    let rawCode = rawCode->String.replaceAll("({}: Demo.Props.t)", "()")
    let rawCode = await formatCode(rawCode, style)

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

@react.component
let make = async (
  ~name=?,
  ~src=?,
  ~title=?,
  ~language=?,
  ~collapsible=true,
  ~className=?,
  ~maxLines=?,
  ~kind=Kind.Component,
  ~lib=Config.Lib.Base,
  ~style=?,
) => {
  let code = switch (name, src) {
  | (None, None) => None
  | (_, Some(src)) => {
      let relativePath =
        src
        ->String.replace("/registry/base/", "")
        ->String.replace("/registry/aria/", "")
      (await Node.Fs.readFile(Node.Path.join([registryRoot(lib), relativePath]), "utf-8"))->Some
    }
  | (Some(name), None) =>
    switch await resolveSourcePath(name, kind, lib) {
    | Some(path) => (await Node.Fs.readFile(path, "utf-8"))->Some
    | None => None
    }
  }

  switch code {
  | None => React.null
  | Some(rawCode) =>
    switch style {
    | Some(style) => <RenderCode rawCode style ?title ?language collapsible ?className ?maxLines />
    | None => {
        // No explicit style → follow the live switcher (Config.Style.default initially).
        let sources = Config.Style.all->Array.map(style => {
          {
            StyleAwareSource.StyleSource.style,
            children: <RenderCode rawCode style ?title ?language collapsible ?maxLines />,
          }
        })

        <StyleAwareSource sources ?className />
      }
    }
  }
}
