@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Dialog>
    <Dialog.Trigger render={<Button variant=Outline />}>
      {"Scrollable Content"->React.string}
    </Dialog.Trigger>
    <Dialog.Content>
      <Dialog.Header>
        <Dialog.Title> {"Scrollable Content"->React.string} </Dialog.Title>
        <Dialog.Description>
          {"This is a dialog with scrollable content."->React.string}
        </Dialog.Description>
      </Dialog.Header>
      <div className="no-scrollbar -mx-4 max-h-[50vh] overflow-y-auto px-4">
        {Array.fromInitializer(~length=10, i =>
          <p key={Int.toString(i)} className="mb-4 leading-normal">
            {"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."->React.string}
          </p>
        )->React.array}
      </div>
    </Dialog.Content>
  </Dialog>
