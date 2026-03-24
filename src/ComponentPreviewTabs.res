@@directive("'use client'")

@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

module Align = {
  @unboxed
  type t =
    | @as("center") Center
    | @as("start") Start
    | @as("end") End
}

module PreviewWrapper = {
  @react.component
  let make = (
    ~align: Align.t,
    ~chromeLessOnMobile,
    ~previewClassName,
    ~dir: option<BaseUi.Types.TextDirection.t>=?,
    ~children,
  ) => {
    <div dataSlot="preview" dir=?{(dir :> option<string>)}>
      <div
        dataAlign={(align :> string)}
        dataChromeless={chromeLessOnMobile}
        className={Commons.cn(
          "preview relative flex h-72 w-full justify-center p-10 data-[align=center]:items-center data-[align=end]:items-end data-[align=start]:items-start data-[chromeless=true]:h-auto data-[chromeless=true]:p-0",
          previewClassName,
        )}
      >
        {children}
      </div>
    </div>
  }
}

module CodeWrapper = {
  @react.component
  let make = (~codeVisible, ~children) => {
    <div
      dataSlot="code"
      dataMobileCodeVisible={codeVisible}
      className="relative overflow-hidden **:data-[slot=copy-button]:right-4 **:data-[slot=copy-button]:hidden data-[mobile-code-visible=true]:**:data-[slot=copy-button]:flex **:data-rehype-pretty-code-figure:m-0! **:data-rehype-pretty-code-figure:rounded-t-none **:data-rehype-pretty-code-figure:border-t [&_pre]:max-h-72"
    >
      {children}
    </div>
  }
}

@react.component
let make = (
  ~className=?,
  ~previewClassName=?,
  ~align=Align.Center,
  ~hideCode=false,
  ~chromeLessOnMobile=false,
  ~component: React.element,
  ~source: React.element,
  ~sourcePreview: React.element,
  ~direction=BaseUi.Types.TextDirection.Ltr,
) => {
  let (codeVisible, setCodeVisible) = React.useState(() => false)

  <div
    dataSlot="component-preview"
    className={Commons.cn(
      "group relative mt-4 mb-12 flex flex-col overflow-hidden rounded-xl border",
      className,
    )}
  >
    <Direction.Provider>
      <PreviewWrapper align chromeLessOnMobile previewClassName dir=direction>
        {component}
      </PreviewWrapper>
    </Direction.Provider>
    {if !hideCode {
      <CodeWrapper codeVisible>
        {if codeVisible {
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
        }}
      </CodeWrapper>
    } else {
      React.null
    }}
  </div>
}
