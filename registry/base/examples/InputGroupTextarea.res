@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="grid w-full max-w-md gap-4">
    <InputGroup>
      <InputGroup.Textarea
        id="textarea-code-32" placeholder="console.log('Hello, world!');" className="min-h-[200px]"
      />
      <InputGroup.Addon align=BlockEnd className="border-t">
        <InputGroup.Text> {"Line 1, Column 1"->React.string} </InputGroup.Text>
        <InputGroup.Button size=Sm className="ml-auto" variant=Default>
          {"Run"->React.string}
          <Icons.CornerDownLeft />
        </InputGroup.Button>
      </InputGroup.Addon>
      <InputGroup.Addon align=BlockStart className="border-b">
        <InputGroup.Text className="font-mono font-medium">
          <Icons.Code />
          {"script.js"->React.string}
        </InputGroup.Text>
        <InputGroup.Button className="ml-auto" size=IconXs>
          <Icons.RefreshCw />
        </InputGroup.Button>
        <InputGroup.Button variant=Ghost size=IconXs>
          <Icons.Copy />
        </InputGroup.Button>
      </InputGroup.Addon>
    </InputGroup>
  </div>
