@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="grid w-full max-w-sm gap-6">
    <InputGroup>
      <Textarea
        dataSlot="input-group-control"
        className="flex field-sizing-content min-h-16 w-full resize-none rounded-md bg-transparent px-3 py-2.5 text-base transition-[color,box-shadow] outline-none md:text-sm"
        placeholder="Autoresize textarea..."
      />
      <InputGroup.Addon align=BlockEnd>
        <InputGroup.Button className="ml-auto" size=Sm variant=Default>
          {"Submit"->React.string}
        </InputGroup.Button>
      </InputGroup.Addon>
    </InputGroup>
  </div>
