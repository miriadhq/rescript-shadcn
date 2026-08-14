@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex w-full max-w-sm flex-col gap-4 py-12">
    <Bubble align=End>
      <Bubble.Content> {"Run the build script."->React.string} </Bubble.Content>
    </Bubble>
    <Bubble variant=Destructive>
      <Bubble.Content> {"Failed to run the command."->React.string} </Bubble.Content>
      <Bubble.Reactions>
        <Popover.Trigger>
          <Button
            variant=Ghost
            size=IconXs
            ariaLabel="Show error details"
            className="aria-expanded:text-destructive"
          >
            <Icons.Info />
          </Button>
          <Popover>
            <Popover.Header>
              <Popover.Title className="text-sm">
                {"Command failed with exit code 1"->React.string}
              </Popover.Title>
              <Popover.Description className="text-sm">
                {"ENOENT: no such file or directory, open pnpm-lock.yaml"->React.string}
              </Popover.Description>
            </Popover.Header>
          </Popover>
        </Popover.Trigger>
      </Bubble.Reactions>
    </Bubble>
  </div>
