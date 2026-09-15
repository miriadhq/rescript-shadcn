@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <HoverCard.Trigger delay=10 closeDelay=100>
    <Button variant=Link> {React.string("Hover Here")} </Button>
    <HoverCard className="flex w-64 flex-col gap-0.5">
      <div className="font-semibold"> {React.string("@nextjs")} </div>
      <div> {React.string("The React Framework – created and maintained by @vercel.")} </div>
      <div className="mt-1 text-xs text-muted-foreground">
        {React.string("Joined December 2021")}
      </div>
    </HoverCard>
  </HoverCard.Trigger>
