@@directive("'use client'")

// Raw JSX helper for elements with custom data-* attributes not in JsxDOM
let previewWrapper: (~align: string, ~previewClassName: option<string>, ~children: React.element) => React.element = %raw(`
  function previewWrapper(align, previewClassName, children) {
    var cn = require("tailwind-merge").twMerge
    var React = require("react")
    return React.createElement("div", {
      "data-slot": "preview",
    },
      React.createElement("div", {
        "data-align": align,
        className: cn(
          "preview relative flex h-72 w-full justify-center p-10 data-[align=center]:items-center data-[align=end]:items-end data-[align=start]:items-start",
          previewClassName
        ),
      }, children)
    )
  }
`)

let codeWrapper: (~codeVisible: bool, ~children: React.element) => React.element = %raw(`
  function codeWrapper(codeVisible, children) {
    var React = require("react")
    return React.createElement("div", {
      "data-slot": "code",
      "data-mobile-code-visible": codeVisible,
      className: "relative overflow-hidden **:data-[slot=copy-button]:right-4 **:data-[slot=copy-button]:hidden data-[mobile-code-visible=true]:**:data-[slot=copy-button]:flex [&_[data-rehype-pretty-code-figure]]:m-0! [&_[data-rehype-pretty-code-figure]]:rounded-t-none [&_[data-rehype-pretty-code-figure]]:border-t [&_pre]:max-h-72",
    }, children)
  }
`)

@react.component
let make = (
  ~className=?,
  ~previewClassName=?,
  ~align="center",
  ~hideCode=false,
  ~component: React.element,
  ~source: React.element,
  ~sourcePreview: React.element,
) => {
  let (codeVisible, setCodeVisible) = React.useState(() => false)

  <div
    className={Commons.cn(
      "group relative mt-4 mb-12 flex flex-col overflow-hidden rounded-xl border",
      className,
    )}
  >
    {previewWrapper(~align, ~previewClassName, ~children=component)}
    {if !hideCode {
      codeWrapper(
        ~codeVisible,
        ~children={
          if codeVisible {
            source
          } else {
            <div className="relative">
              sourcePreview
              <div className="absolute inset-0 flex items-center justify-center pb-4">
                <div
                  className="absolute inset-0"
                  style={{
                    background: "linear-gradient(to top, var(--color-code), color-mix(in oklab, var(--color-code) 60%, transparent), transparent)",
                  }}
                />
                <Button
                  type_="button"
                  size=Sm
                  variant=Outline
                  className="relative z-10 rounded-lg bg-background text-foreground shadow-none hover:bg-muted dark:bg-background dark:text-foreground dark:hover:bg-muted"
                  onClick={_ => setCodeVisible(_ => true)}
                >
                  {"View Code"->React.string}
                </Button>
              </div>
            </div>
          }
        },
      )
    } else {
      React.null
    }}
  </div>
}
