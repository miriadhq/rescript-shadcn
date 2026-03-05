// For elements with custom data-* attributes not in JsxDOM
@module("react") external jsxs: (string, {..}) => React.element = "createElement"
@module("react") @variadic
external jsxc: (string, {..}, array<React.element>) => React.element = "createElement"

let getMonorepoRoot = () => {
  let dir = Node.cwd()
  if dir->String.endsWith("apps/v4") || dir->String.endsWith("apps\\v4") {
    Node.Path.join([dir, "..", ".."])
  } else {
    dir
  }
}

let rescriptRoot = Node.Path.join([getMonorepoRoot(), "packages/shadcn/rescript"])
let rescriptDemosRoot = Node.Path.join([rescriptRoot, "demo"])
let rescriptSourcePathCache: Map.t<string, Nullable.t<string>> = Map.make()

let toPascalCase = (name: string) =>
  name
  ->String.split("-")
  ->Array.filter(s => s !== "")
  ->Array.map(part => {
    let first = part->String.slice(~start=0, ~end=1)->String.toUpperCase
    let rest = part->String.slice(~start=1)
    first ++ rest
  })
  ->Array.join("")

let getBaseFromStyleName = (styleName: string) => styleName->String.split("-")->Array.getUnsafe(0)

let getDemoStem = (name: string) => {
  if name->String.endsWith("-demo") {
    Some(name->String.slice(~start=0, ~end=name->String.length - 5))
  } else if name->String.endsWith("-example") {
    Some(name->String.slice(~start=0, ~end=name->String.length - 8))
  } else {
    None
  }
}

let fileExists = async (filePath: string) => {
  try {
    await Node.Fs.access(filePath)
    true
  } catch {
  | _ => false
  }
}

let validNameRe = /^[a-z0-9-]+$/

let resolveReScriptSourcePath = async (name: string, styleName: string) => {
  let cacheKey = `${styleName}:${name}`
  if Map.has(rescriptSourcePathCache, cacheKey) {
    Map.get(rescriptSourcePathCache, cacheKey)->Option.flatMap(Nullable.toOption)
  } else {
    let base = getBaseFromStyleName(styleName)
    if base != "base" || !RegExp.test(validNameRe, name) {
      Map.set(rescriptSourcePathCache, cacheKey, Nullable.null)
      None
    } else {
      let componentPath = Node.Path.join([rescriptRoot, `${toPascalCase(name)}.res`])
      if await fileExists(componentPath) {
        Map.set(rescriptSourcePathCache, cacheKey, Nullable.Value(componentPath))
        Some(componentPath)
      } else {
        let found = ref(None)

        switch getDemoStem(name) {
        | Some(stem) =>
          let demoPath = Node.Path.join([rescriptDemosRoot, `${toPascalCase(stem)}Demo.res`])
          if await fileExists(demoPath) {
            Map.set(rescriptSourcePathCache, cacheKey, Nullable.Value(demoPath))
            found := Some(demoPath)
          }
        | None => ()
        }

        if found.contents->Option.isNone {
          let demoPathFromName = Node.Path.join([
            rescriptDemosRoot,
            `${toPascalCase(name)}Demo.res`,
          ])
          if await fileExists(demoPathFromName) {
            Map.set(rescriptSourcePathCache, cacheKey, Nullable.Value(demoPathFromName))
            found := Some(demoPathFromName)
          }
        }

        if found.contents->Option.isNone {
          Map.set(rescriptSourcePathCache, cacheKey, Nullable.null)
        }

        found.contents
      }
    }
  }
}

let getDisplayLanguage = (~language=?, ~sourcePath=?, ~title=?) => {
  switch language {
  | Some(l) => l
  | None =>
    let extensionFromPath =
      sourcePath->Option.map(p => Node.Path.extname(p)->String.slice(~start=1))
    let extensionFromTitle = title->Option.flatMap(t => {
      let parts = t->String.split(".")
      parts->Array.get(parts->Array.length - 1)
    })
    let extension = switch extensionFromPath {
    | Some(e) if e !== "" => Some(e)
    | _ => extensionFromTitle
    }
    switch extension {
    | Some("res") => "rescript"
    | Some(e) => e
    | None => "rescript"
    }
  }
}

module ComponentCode = {
  @react.component
  let make = (~code, ~highlightedCode, ~language, ~title=?) => {
    let titleEl = switch title {
    | Some(t) =>
      jsxc(
        "figcaption",
        {
          "data-rehype-pretty-code-title": "",
          "className": "text-code-foreground [&_svg]:text-code-foreground flex items-center gap-2 [&_svg]:size-4 [&_svg]:opacity-70",
          "data-language": language,
        },
        [BrandIcons.getIconForLanguageExtension(language), t->React.string],
      )
    | None => React.null
    }

    let codeDiv = jsxs(
      "div",
      {
        "className": "[&_pre]:!bg-[var(--color-code)] [&_pre]:!text-[var(--color-code-foreground)] [&_pre[data-theme='github-dark']]:!block dark:[&_pre[data-theme='github-dark']]:!block [&_pre[data-theme='github-light']]:!hidden dark:[&_pre[data-theme='github-light']]:!hidden",
        "suppressHydrationWarning": true,
        "dangerouslySetInnerHTML": {"__html": highlightedCode},
      },
    )

    jsxc(
      "figure",
      {
        "data-rehype-pretty-code-figure": "",
        "className": "[&>pre]:max-h-96",
        "suppressHydrationWarning": true,
      },
      [titleEl, <CopyButton value=code />, codeDiv],
    )
  }
}

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
    let styleName = props.styleName->Option.getOr("new-york-v4")

    let codeAndPath: option<(string, option<string>)> = switch props.name {
    | Some(name) =>
      switch await resolveReScriptSourcePath(name, styleName) {
      | Some(rescriptPath) =>
        try {
          let fileCode = await Node.Fs.readFile(rescriptPath, "utf-8")
          Some((fileCode, Some(rescriptPath)))
        } catch {
        | exn =>
          Console.error2(`Error reading ReScript file ${rescriptPath}:`, exn)
          None
        }
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
      let displayLanguage = getDisplayLanguage(
        ~language=?props.language,
        ~sourcePath?,
        ~title=?props.title,
      )
      let code = rawCode->String.replaceAll("/* eslint-disable react/no-children-prop */\n", "")
      let code = switch props.maxLines {
      | Some(ml) => code->String.split("\n")->Array.slice(~start=0, ~end=ml)->Array.join("\n")
      | None => code
      }

      let highlightedCode = try {
        await HighlightCode.highlightCode(code, ~language=displayLanguage)
      } catch {
      | _ => await HighlightCode.highlightCode(code, ~language="text")
      }

      let componentCodeEl =
        <ComponentCode code highlightedCode language=displayLanguage title=?props.title />

      if !collapsible {
        <div className={Commons.cn("relative", props.className)}> componentCodeEl </div>
      } else {
        <CodeCollapsibleWrapper className=?props.className>
          componentCodeEl
        </CodeCollapsibleWrapper>
      }
    }
  }
}
