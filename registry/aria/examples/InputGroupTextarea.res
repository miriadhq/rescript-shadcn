module IconCornerDownLeft = {
  @module("@tabler/icons-react") external make: React.component<Icons.props> = "IconCornerDownLeft"
}
module IconBrandJavascript = {
  @module("@tabler/icons-react") external make: React.component<Icons.props> = "IconBrandJavascript"
}
module IconRefresh = {
  @module("@tabler/icons-react") external make: React.component<Icons.props> = "IconRefresh"
}
module IconCopy = {
  @module("@tabler/icons-react") external make: React.component<Icons.props> = "IconCopy"
}

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
          <IconCornerDownLeft />
        </InputGroup.Button>
      </InputGroup.Addon>
      <InputGroup.Addon align=BlockStart className="border-b">
        <InputGroup.Text className="font-mono font-medium">
          <IconBrandJavascript />
          {"script.js"->React.string}
        </InputGroup.Text>
        <InputGroup.Button className="ml-auto" size=IconXs>
          <IconRefresh />
        </InputGroup.Button>
        <InputGroup.Button variant=Ghost size=IconXs>
          <IconCopy />
        </InputGroup.Button>
      </InputGroup.Addon>
    </InputGroup>
  </div>
