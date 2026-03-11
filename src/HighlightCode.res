module Crypto = {
  type hash
  @module("crypto") external createHash: string => hash = "createHash"
  @send external update: (hash, string) => hash = "update"
  @send external digest: (hash, string) => string = "digest"
}

module LRUCache = {
  type t
  @module("lru-cache") @new external make: {"max": int, "ttl": int} => t = "LRUCache"
  @send @return(nullable) external get: (t, string) => option<string> = "get"
  @send external set: (t, string, string) => unit = "set"
}

module Shiki = {
  type highlighter
  module LanguageRegistration = {
    type t = {
      name: string,
      scopeName: string,
      displayName?: string,
      aliases?: array<string>,
      embeddedLangs?: array<string>,
      embeddedLangsLazy?: array<string>,
      balancedBracketSelectors?: array<string>,
      unbalancedBracketSelectors?: array<string>,
      foldingStopMarker?: string,
      foldingStartMarker?: string,
      /**
     * Inject this language to other scopes.
     * Same as `injectTo` in VSCode's `contributes.grammars`.
     *
     * @see https://code.visualstudio.com/api/language-extensions/syntax-highlight-guide#injection-grammars
     */
      injectTo?: array<string>,
    }
  }
  module Node = {
    type t = {
      tagName: string,
      properties: dict<string>,
    }
  }
  module Transformer = {
    module Base = {
      type t = {
        source: string,
      }
    }
    type t = {
      code: @this (Base.t, Node.t) => unit,
      pre?: @this (Base.t, Node.t) => unit,
      line?: @this (Base.t, Node.t) => unit,
    }
  }

  module CreateHighlighterOptions = {
    module Lang = {
      @unboxed
      type t =
        | String(string)
        | LanguageRegistration(LanguageRegistration.t)
    }
    type t = {
      themes: array<string>,
      langs: array<Lang.t>,
    }
  }

  @module("shiki")
  external createHighlighter: CreateHighlighterOptions.t => promise<highlighter> =
    "createHighlighter"

  module CodeToHtmlOptions = {
    type t = {
      lang: string,
      themes: dict<string>,
      transformers: array<Transformer.t>,
    }
  }

  @send
  external codeToHtml: (highlighter, string, CodeToHtmlOptions.t) => string = "codeToHtml"
}

@module("../grammars/rescript.tmLanguage.json")
external rescriptTmLanguage: Shiki.LanguageRegistration.t = "default"

let rescriptLanguage = {
  ...rescriptTmLanguage,
  name: "rescript",
  displayName: "ReScript",
  aliases: ["res"],
  embeddedLangs: ["javascript"],
}

let highlightCache = LRUCache.make({"max": 500, "ttl": 1000 * 60 * 60})

let codeThemes = dict{
  "dark": "github-dark",
  "light": "github-light",
}

let highlighterPromise: ref<option<promise<Shiki.highlighter>>> = ref(None)

let getHighlighter = () => {
  switch highlighterPromise.contents {
  | Some(p) => p
  | None =>
    open Shiki.CreateHighlighterOptions.Lang
    let langs = [
      String("tsx"),
      String("typescript"),
      String("ts"),
      String("jsx"),
      String("javascript"),
      String("js"),
      String("css"),
      String("json"),
      String("bash"),
      String("html"),
      String("mdx"),
      String("text"),
      LanguageRegistration(rescriptLanguage),
    ]
    let p = Shiki.createHighlighter({
      themes: ["github-dark", "github-light"],
      langs,
    })
    highlighterPromise := Some(p)
    p
  }
}

let normalizeLanguage = (language: string) => {
  switch language->String.toLowerCase {
  | "res" | "rescript" => "rescript"
  | _ => language
  }
}

let transformers: array<Shiki.Transformer.t> = [
  {
    code: @this
    (this, {Shiki.Node.tagName: tagName, properties}) => {
      if tagName === "code" {
        let raw = this.Shiki.Transformer.Base.source
        properties->Dict.set("__raw__", raw)

        if raw->String.startsWith("npm install") {
          properties->Dict.set("__npm__", raw)
          properties->Dict.set("__yarn__", raw->String.replace("npm install", "yarn add"))
          properties->Dict.set("__pnpm__", raw->String.replace("npm install", "pnpm add"))
          properties->Dict.set("__bun__", raw->String.replace("npm install", "bun add"))
        }

        if raw->String.startsWith("npx") {
          properties->Dict.set("__npm__", raw)
          properties->Dict.set("__yarn__", raw->String.replace("npx", "yarn"))
          properties->Dict.set("__pnpm__", raw->String.replace("npx", "pnpm dlx"))
          properties->Dict.set("__bun__", raw->String.replace("npx", "bunx --bun"))
        }

        if raw->String.startsWith("npm run") {
          properties->Dict.set("__npm__", raw)
          properties->Dict.set("__yarn__", raw->String.replace("npm run", "yarn"))
          properties->Dict.set("__pnpm__", raw->String.replace("npm run", "pnpm"))
          properties->Dict.set("__bun__", raw->String.replace("npm run", "bun"))
        }
      }
    },
  },
]

let renderTransformers = [
  {
    Shiki.Transformer.pre: @this
    (_, {Shiki.Node.properties: properties}) => {
      properties->Dict.set(
        "class",
        "no-scrollbar min-w-0 overflow-x-auto overflow-y-auto overscroll-x-contain overscroll-y-auto px-4 py-3.5 outline-none has-[[data-highlighted-line]]:px-0 has-[[data-line-numbers]]:px-0 has-[[data-slot=tabs]]:p-0 !bg-transparent",
      )
    },
    code: @this
    (_, {Shiki.Node.properties: properties}) => {
      properties->Dict.set("data-line-numbers", "")
    },
    line: @this
    (_, {Shiki.Node.properties: properties}) => {
      properties->Dict.set("data-line", "")
    },
  },
]

let highlightCode = async (code, ~language="rescript") => {
  let normalizedLanguage = normalizeLanguage(language)

  let cacheKey =
    Crypto.createHash("sha256")
    ->Crypto.update(`${normalizedLanguage}:${code}`)
    ->Crypto.digest("hex")

  switch LRUCache.get(highlightCache, cacheKey) {
  | Some(cached) => cached
  | None =>
    let highlighter = await getHighlighter()

    let html = try {
      Shiki.codeToHtml(
        highlighter,
        code,
        {
          lang: normalizedLanguage,
          themes: codeThemes,
          transformers: renderTransformers,
        },
      )
    } catch {
    | JsExn(error) =>
      Console.error2("Error highlighting code", error->JsExn.message)
      Shiki.codeToHtml(
        highlighter,
        code,
        {lang: "text", themes: codeThemes, transformers: renderTransformers},
      )
    }

    LRUCache.set(highlightCache, cacheKey, html)
    html
  }
}
