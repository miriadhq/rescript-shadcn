@@directive("'use client'")

type spacingOption = {className: string, label: string, value: string}

let spacingOptions: array<spacingOption> = [
  {className: "[--card-spacing:--spacing(4)]", label: "16px", value: "4"},
  {className: "[--card-spacing:--spacing(5)]", label: "20px", value: "5"},
  {className: "[--card-spacing:--spacing(6)]", label: "24px", value: "6"},
  {className: "[--card-spacing:--spacing(8)]", label: "32px", value: "8"},
]

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (spacing, setSpacing) = React.useState(() => "4")
  let selectedSpacing = spacingOptions->Array.find(option => option.value == spacing)

  <div className="mx-auto grid w-full max-w-sm gap-4">
    <ToggleGroup
      selectedKeys={[spacing]}
      onSelectionChange={keys =>
        keys
        ->Set.values
        ->Iterator.toArray
        ->Array.get(0)
        ->Option.forEach(spacing => setSpacing(_ => spacing))}
      variant=Outline
      size=Sm
      className="justify-center"
    >
      {spacingOptions
      ->Array.map(option =>
        <ToggleGroup.Item key={option.value} id={option.value}>
          {option.label->React.string}
        </ToggleGroup.Item>
      )
      ->React.array}
    </ToggleGroup>
    <Card className=?{selectedSpacing->Option.map(option => option.className)}>
      <Card.Header>
        <Card.Title> {"Login to your account"->React.string} </Card.Title>
        <Card.Description>
          {"Enter your email below to login to your account"->React.string}
        </Card.Description>
        <Card.Action>
          <Button variant=Link> {"Sign Up"->React.string} </Button>
        </Card.Action>
      </Card.Header>
      <Card.Content>
        <form>
          <div className="flex flex-col gap-6">
            <div className="grid gap-2">
              <Label htmlFor="email-spacing"> {"Email"->React.string} </Label>
              <Input
                id="email-spacing" type_="email" placeholder="m@example.com" required={true}
              />
            </div>
            <div className="grid gap-2">
              <div className="flex items-center">
                <Label htmlFor="password-spacing"> {"Password"->React.string} </Label>
                <a
                  href="#"
                  className="ml-auto inline-block text-sm underline-offset-4 hover:underline"
                >
                  {"Forgot your password?"->React.string}
                </a>
              </div>
              <Input id="password-spacing" type_="password" required={true} />
            </div>
          </div>
        </form>
      </Card.Content>
      <Card.Footer className="flex-col gap-2">
        <Button type_="submit" className="w-full"> {"Login"->React.string} </Button>
        <Button variant=Outline className="w-full"> {"Login with Google"->React.string} </Button>
      </Card.Footer>
    </Card>
  </div>
}
