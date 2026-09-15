@@directive("'use client'")

module IconCheck = {
  @module("@tabler/icons-react") external make: React.component<Icons.props> = "IconCheck"
}
module IconCopy = {
  @module("@tabler/icons-react") external make: React.component<Icons.props> = "IconCopy"
}
module IconInfoCircle = {
  @module("@tabler/icons-react") external make: React.component<Icons.props> = "IconInfoCircle"
}
module IconStar = {
  type props = {...Icons.props, @as("data-favorite") dataFavorite?: bool}
  @module("@tabler/icons-react") external make: React.component<props> = "IconStar"
}
@scope(("navigator", "clipboard")) @val
external writeText: string => promise<unit> = "writeText"

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (isFavorite, setIsFavorite) = React.useState(() => false)
  let (isCopied, setIsCopied) = React.useState(() => false)
  React.useEffect(() => {
    if isCopied {
      let timer = setTimeout(~handler=() => setIsCopied(_ => false), ~timeout=2000)
      Some(() => clearTimeout(timer))
    } else {
      None
    }
  }, [isCopied])
  let copy = _ => {
    let run = async () => {
      try {
        await writeText("https://x.com/shadcn")
        setIsCopied(_ => true)
      } catch {
      | _ => Sonner.error("Could not copy to clipboard"->React.string)
      }
    }
    run()->ignore
  }
  <div className="grid w-full max-w-sm gap-6">
    <InputGroup>
      <InputGroup.Input placeholder="https://x.com/shadcn" readOnly=true />
      <InputGroup.Addon align=InlineEnd>
        <InputGroup.Button ariaLabel="Copy" title="Copy" size=IconXs onClick=copy>
          {isCopied ? <IconCheck /> : <IconCopy />}
        </InputGroup.Button>
      </InputGroup.Addon>
    </InputGroup>
    <InputGroup className="[--radius:9999px]">
      <Popover>
        <Popover.Trigger render={<InputGroup.Addon />}>
          <InputGroup.Button variant=Secondary size=IconXs>
            <IconInfoCircle />
          </InputGroup.Button>
        </Popover.Trigger>
        <Popover.Content align=Start className="flex flex-col gap-1 rounded-xl text-sm">
          <p className="font-medium"> {"Your connection is not secure."->React.string} </p>
          <p> {"You should not enter any sensitive information on this site."->React.string} </p>
        </Popover.Content>
      </Popover>
      <InputGroup.Addon className="pl-1.5 text-muted-foreground">
        {"https://"->React.string}
      </InputGroup.Addon>
      <InputGroup.Input id="input-secure-19" />
      <InputGroup.Addon align=InlineEnd>
        <InputGroup.Button onClick={_ => setIsFavorite(value => !value)} size=IconXs>
          <IconStar
            dataFavorite=isFavorite
            className="data-[favorite=true]:fill-blue-600 data-[favorite=true]:stroke-blue-600"
          />
        </InputGroup.Button>
      </InputGroup.Addon>
    </InputGroup>
    <InputGroup>
      <InputGroup.Input placeholder="Type to search..." />
      <InputGroup.Addon align=InlineEnd>
        <InputGroup.Button variant=Secondary> {"Search"->React.string} </InputGroup.Button>
      </InputGroup.Addon>
    </InputGroup>
  </div>
}
