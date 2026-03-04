@@directive("'use client'")

@react.component
let make = () => {
  let (isFavorite, setIsFavorite) = React.useState(() => false)

  <div className="grid w-full max-w-sm gap-6">
    <InputGroup>
      <InputGroup.Input placeholder="https://x.com/shadcn" readOnly={true} />
      <InputGroup.Addon align=InlineEnd>
        <InputGroup.Button ariaLabel="Copy" size=IconXs>
          <Icons.Download />
        </InputGroup.Button>
      </InputGroup.Addon>
    </InputGroup>
    <InputGroup>
      <InputGroup.Input placeholder="Enter your message" />
      <InputGroup.Addon align=InlineEnd>
        <InputGroup.Button variant=Secondary> {"Search"->React.string} </InputGroup.Button>
      </InputGroup.Addon>
    </InputGroup>
    <InputGroup>
      <InputGroup.Input placeholder="Type to search..." />
      <InputGroup.Addon align=InlineEnd>
        <InputGroup.Button onClick={_ => setIsFavorite(f => !f)} size=IconXs>
          <Icons.Info
            dataIcon={isFavorite ? "true" : "false"}
            className="data-[icon=true]:fill-blue-600 data-[icon=true]:stroke-blue-600"
          />
        </InputGroup.Button>
      </InputGroup.Addon>
    </InputGroup>
  </div>
}
