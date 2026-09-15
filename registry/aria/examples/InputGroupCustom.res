module TextareaAutosize = {
  type props = {...JsxDOM.domProps, @as("data-slot") dataSlot?: string}
  @module("react-textarea-autosize")
  external make: React.component<props> = "default"
}

@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="grid w-full max-w-sm gap-6">
    <InputGroup>
      <TextareaAutosize
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
