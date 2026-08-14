@@directive("'use client'")

type browserWindow
type mediaQueryList

@val external browserWindow: browserWindow = "window"
@send external windowMatchMedia: (browserWindow, string) => mediaQueryList = "matchMedia"
@get external mediaQueryMatches: mediaQueryList => bool = "matches"
@send
external addMediaQueryListener: (mediaQueryList, string, unit => unit) => unit = "addEventListener"
@send
external removeMediaQueryListener: (mediaQueryList, string, unit => unit) => unit =
  "removeEventListener"

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

let useMediaQuery = (query: string) => {
  let (matches, setMatches) = React.useState(() => false)

  React.useEffect(() => {
    let mediaQuery = browserWindow->windowMatchMedia(query)
    let onChange = () => setMatches(_ => mediaQuery->mediaQueryMatches)

    mediaQuery->addMediaQueryListener("change", onChange)
    onChange()

    Some(() => mediaQuery->removeMediaQueryListener("change", onChange))
  }, [query])

  matches
}

module ProfileForm = {
  @react.component
  let make = (~className=?) => {
    <form className={cn("grid items-start gap-6", className)}>
      <div className="grid gap-3">
        <Label htmlFor="email"> {"Email"->React.string} </Label>
        <Input type_="email" id="email" defaultValue="shadcn@example.com" />
      </div>
      <div className="grid gap-3">
        <Label htmlFor="username"> {"Username"->React.string} </Label>
        <Input id="username" defaultValue="@shadcn" />
      </div>
      <Button type_="submit"> {"Save changes"->React.string} </Button>
    </form>
  }
}

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (open_, setOpen) = React.useState(() => false)
  let isDesktop = useMediaQuery("(min-width: 768px)")

  if isDesktop {
    <Dialog.Trigger isOpen=open_ onOpenChange={nextOpen => setOpen(_ => nextOpen)}>
      <Button variant=Outline> {"Edit Profile"->React.string} </Button>
      <Dialog className="sm:max-w-[425px]">
        <Dialog.Header>
          <Dialog.Title> {"Edit profile"->React.string} </Dialog.Title>
          <Dialog.Description>
            {"Make changes to your profile here. Click save when you're done."->React.string}
          </Dialog.Description>
        </Dialog.Header>
        <ProfileForm />
      </Dialog>
    </Dialog.Trigger>
  } else {
    <Drawer open_ onOpenChange={(nextOpen, _) => setOpen(_ => nextOpen)}>
      <Drawer.Trigger render={<Button variant=Outline />}>
        {"Edit Profile"->React.string}
      </Drawer.Trigger>
      <Drawer.Content>
        <Drawer.Header className="text-left">
          <Drawer.Title> {"Edit profile"->React.string} </Drawer.Title>
          <Drawer.Description>
            {"Make changes to your profile here. Click save when you're done."->React.string}
          </Drawer.Description>
        </Drawer.Header>
        <ProfileForm className="px-4" />
        <Drawer.Footer className="pt-2">
          <Drawer.Close render={<Button variant=Outline />}>
            {"Cancel"->React.string}
          </Drawer.Close>
        </Drawer.Footer>
      </Drawer.Content>
    </Drawer>
  }
}
