@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

@@directive("'use client'")

module ListItem = {
  @react.component
  let make = (
    ~title: string,
    ~href: string,
    ~children: React.element,
    ~id=?,
    ~style=?,
    ~className=?,
    ~onClick=?,
    ~onKeyDown=?,
  ) =>
    <li ?id ?style ?className ?onClick ?onKeyDown>
      <NavigationMenu.Link render={<Next.Link href />}>
        <div className="flex flex-col gap-1 text-sm">
          <div className="leading-none font-medium"> {title->React.string} </div>
          <div className="text-muted-foreground line-clamp-2"> {children} </div>
        </div>
      </NavigationMenu.Link>
    </li>
}
