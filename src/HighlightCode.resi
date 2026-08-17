module Shiki: {
  module Highlighter: {
    type t
  }
  module Node: {
    type t = {
      tagName: string,
      properties: dict<string>,
    }
  }
  module Transformer: {
    module Meta: {
      type t = {@as("__raw") raw?: string}
    }
    module Options: {
      type t = {meta?: Meta.t}
    }
    module Base: {
      type t = {
        source: string,
        options: Options.t,
      }
    }
    type t = {
      code: @this (Base.t, Node.t) => unit,
      pre?: @this (Base.t, Node.t) => unit,
      line?: @this (Base.t, Node.t) => unit,
    }
  }
}

let getHighlighter: unit => promise<Shiki.Highlighter.t>

let transformers: array<Shiki.Transformer.t>

let highlightCode: (string, ~language: string=?) => promise<string>
