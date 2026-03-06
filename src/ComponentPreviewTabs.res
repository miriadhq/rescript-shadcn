@@directive("'use client'")

@module("react") external jsxs: (string, {..}) => React.element = "createElement"

@react.component
let make = (
  ~className=?,
  ~previewClassName=?,
  ~align="center",
  ~hideCode=false,
  ~component: React.element,
  ~source: React.element,
  ~sourcePreview: option<React.element>=?,
) => {
  let (codeVisible, setCodeVisible) = React.useState(() => false)

  let previewDiv = jsxs(
    "div",
    {
      "data-align": align,
      "className": Commons.cn(
        "preview relative flex h-72 w-full justify-center p-10 data-[align=center]:items-center data-[align=end]:items-end data-[align=start]:items-start",
        previewClassName,
      ),
      "children": component,
    },
  )

  let codeSection = if !hideCode {
    let inner = if codeVisible {
      source
    } else {
      <div className="relative">
        {sourcePreview->Option.getOr(React.null)}
        <div className="absolute inset-0 flex items-center justify-center pb-4">
          <div
            className="absolute inset-0"
            style={{
              background: "linear-gradient(to top, var(--color-code), color-mix(in oklab, var(--color-code) 60%, transparent), transparent)",
            }}
          />
          <Button
            size={Sm}
            variant={Outline}
            className="bg-background text-foreground dark:bg-background dark:text-foreground hover:bg-muted dark:hover:bg-muted relative z-10 rounded-lg shadow-none"
            onClick={_ => setCodeVisible(_ => true)}
          >
            {"View Code"->React.string}
          </Button>
        </div>
      </div>
    }
    jsxs(
      "div",
      {
        "data-mobile-code-visible": codeVisible->string_of_bool,
        "className": "relative overflow-hidden **:data-[slot=copy-button]:right-4 **:data-[slot=copy-button]:hidden data-[mobile-code-visible=true]:**:data-[slot=copy-button]:flex [&_[data-rehype-pretty-code-figure]]:!m-0 [&_[data-rehype-pretty-code-figure]]:rounded-t-none [&_[data-rehype-pretty-code-figure]]:border-t [&_pre]:max-h-72",
        "children": inner,
      },
    )
  } else {
    React.null
  }

  <div
    className={Commons.cn(
      "group relative mt-4 mb-12 flex flex-col overflow-hidden rounded-xl border",
      className,
    )}
  >
    <div> previewDiv </div>
    codeSection
  </div>
}
