let registryRoot = Node.Path.join([Node.cwd(), "registry/base"])

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

let getLanguage = (~language=?, ~sourcePath=?, ~title=?) => {
  switch language {
  | Some(l) => l
  | None =>
    let ext = switch sourcePath {
    | Some(p) =>
      let e = Node.Path.extname(p)->String.slice(~start=1)
      if e !== "" {
        Some(e)
      } else {
        None
      }
    | None =>
      title->Option.flatMap(t => {
        let parts = t->String.split(".")
        parts->Array.get(parts->Array.length - 1)
      })
    }
    switch ext {
    | Some("res") | None => "rescript"
    | Some(e) => e
    }
  }
}

// Raw JSX helper for elements with custom data-* attributes not in JsxDOM
let componentCode: (
  ~code: string,
  ~highlightedCode: string,
  ~language: string,
  ~title: string=?,
) => React.element = %raw(`function componentCode(code, highlightedCode, language, title) {
  var React = require("react")
  var CopyButton = require("./CopyButton.res.mjs")
  var BrandIcons = require("./BrandIcons.res.mjs")

  return React.createElement("figure", {
    "data-rehype-pretty-code-figure": "",
    className: "[&>pre]:max-h-96"
  },
    title
      ? React.createElement("figcaption", {
          "data-rehype-pretty-code-title": "",
          className: "flex items-center gap-2 text-code-foreground [&_svg]:size-4 [&_svg]:text-code-foreground [&_svg]:opacity-70",
          "data-language": language
        }, BrandIcons.getIconForLanguageExtension(language), title)
      : null,
    React.createElement(CopyButton.make, { value: code }),
    React.createElement("div", { dangerouslySetInnerHTML: { __html: highlightedCode } })
  )
}`)

type props = {
  name?: string,
  src?: string,
  title?: string,
  language?: string,
  collapsible?: bool,
  className?: string,
  styleName?: string,
  maxLines?: int,
}

let make = async (props: props) => {
  if props.name->Option.isNone && props.src->Option.isNone {
    React.null
  } else {
    let collapsible = props.collapsible->Option.getOr(true)

    let codeAndPath: option<(string, option<string>)> = switch props.name {
    | Some(name) =>
      switch await resolveSourcePath(name) {
      | Some(sourcePath) =>
        let fileCode = await Node.Fs.readFile(sourcePath, "utf-8")
        Some((fileCode, Some(sourcePath)))
      | None => None
      }
    | None =>
      switch props.src {
      | Some(s) =>
        let resolvedPath = Node.Path.join([Node.cwd(), s])
        let fileCode = await Node.Fs.readFile(resolvedPath, "utf-8")
        Some((fileCode, Some(resolvedPath)))
      | None => None
      }
    }

    switch codeAndPath {
    | None => React.null
    | Some((rawCode, sourcePath)) =>
      let lang = getLanguage(~language=?props.language, ~sourcePath?, ~title=?props.title)

      let code = switch props.maxLines {
      | Some(ml) => rawCode->String.split("\n")->Array.slice(~start=0, ~end=ml)->Array.join("\n")
      | None => rawCode
      }

      let highlightedCode = try {
        await HighlightCode.highlightCode(code, ~language=lang)
      } catch {
      | _ => await HighlightCode.highlightCode(code, ~language="text")
      }

      let codeEl = componentCode(~code, ~highlightedCode, ~language=lang, ~title=?props.title)

      if !collapsible {
        <div className={Commons.cn("relative", props.className)}> codeEl </div>
      } else {
        <CodeCollapsibleWrapper className=?props.className> codeEl </CodeCollapsibleWrapper>
      }
    }
  }
}
