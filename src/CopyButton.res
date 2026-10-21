@@directive("'use client'")

module TablerIcons = {
  type props = {className?: string}

  module IconCheck = {
    @module("@tabler/icons-react")
    external make: React.component<props> = "IconCheck"
  }

  module IconCopy = {
    @module("@tabler/icons-react")
    external make: React.component<props> = "IconCopy"
  }
}

@val @scope(("navigator", "clipboard"))
external writeText: string => promise<unit> = "writeText"

let copyToClipboardWithMeta = (value: string) => {
  writeText(value)->ignore
}

@react.component
let make = (~value, ~className=?, ~variant=Button.Variant.Ghost) => {
  let (hasCopied, setHasCopied) = React.useState(() => false)

  React.useEffect(() => {
    if hasCopied {
      let timer = setTimeout(() => setHasCopied(_ => false), 2000)
      Some(() => clearTimeout(timer))
    } else {
      None
    }
  }, [hasCopied])

  <Button
    dataSlot="copy-button"
    size=Icon
    variant
    className={Commons.cn(
      "absolute top-3 right-2 z-10 size-7 bg-code hover:opacity-100 focus-visible:opacity-100",
      className,
    )}
    onClick={_ => {
      copyToClipboardWithMeta(value)
      setHasCopied(_ => true)
    }}
  >
    <span className="sr-only"> {"Copy"->React.string} </span>
    {hasCopied ? <TablerIcons.IconCheck /> : <TablerIcons.IconCopy />}
  </Button>
}
