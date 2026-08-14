@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (isOpen, setIsOpen) = React.useState(() => false)

  <Card className="mx-auto w-full max-w-xs" size=Sm>
    <Card.Header>
      <Card.Title> {"Radius"->React.string} </Card.Title>
      <Card.Description> {"Set the corner radius of the element."->React.string} </Card.Description>
    </Card.Header>
    <Card.Content>
      <Collapsible
        isExpanded=isOpen
        onExpandedChange={nextOpen => setIsOpen(_ => nextOpen)}
        className="flex items-start gap-2"
      >
        <Field.Group className="grid w-full grid-cols-2 gap-2">
          <Field>
            <Field.Label htmlFor="radius-x" className="sr-only">
              {"Radius X"->React.string}
            </Field.Label>
            <Input id="radius" placeholder="0" defaultValue="0" />
          </Field>
          <Field>
            <Field.Label htmlFor="radius-y" className="sr-only">
              {"Radius Y"->React.string}
            </Field.Label>
            <Input id="radius" placeholder="0" defaultValue="0" />
          </Field>
          <Collapsible.Content>
            <div className="col-span-full grid grid-cols-subgrid gap-2">
              <Field>
                <Field.Label htmlFor="radius-x" className="sr-only">
                  {"Radius X"->React.string}
                </Field.Label>
                <Input id="radius" placeholder="0" defaultValue="0" />
              </Field>
              <Field>
                <Field.Label htmlFor="radius-y" className="sr-only">
                  {"Radius Y"->React.string}
                </Field.Label>
                <Input id="radius" placeholder="0" defaultValue="0" />
              </Field>
            </div>
          </Collapsible.Content>
        </Field.Group>
        <Button slot="trigger" variant=Outline size=Icon>
          {if isOpen {
            <Icons.Minimize />
          } else {
            <Icons.Maximize />
          }}
        </Button>
      </Collapsible>
    </Card.Content>
  </Card>
}
