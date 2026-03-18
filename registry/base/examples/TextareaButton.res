@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="grid w-full gap-2">
    <Textarea placeholder="Type your message here." />
    <Button> {"Send message"->React.string} </Button>
  </div>
