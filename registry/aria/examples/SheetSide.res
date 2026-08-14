let sheetSides = [
  (Sheet.Side.Top, "top"),
  (Sheet.Side.Right, "right"),
  (Sheet.Side.Bottom, "bottom"),
  (Sheet.Side.Left, "left"),
]

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex flex-wrap gap-2">
    {sheetSides
    ->Array.map(((side, label)) =>
      <Sheet.Trigger key=label>
        <Button variant=Outline className="capitalize"> {label->React.string} </Button>
        <Sheet
          side className="data-[side=bottom]:max-h-[50vh] data-[side=top]:max-h-[50vh]"
        >
          <Sheet.Header>
            <Sheet.Title> {"Edit profile"->React.string} </Sheet.Title>
            <Sheet.Description>
              {"Make changes to your profile here. Click save when you're done."->React.string}
            </Sheet.Description>
          </Sheet.Header>
          <div className="no-scrollbar overflow-y-auto px-4">
            {Array.fromInitializer(~length=10, index =>
              <p key={Int.toString(index)} className="mb-2 leading-relaxed">
                {"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed 
                do eiusmod tempor incididunt ut labore et dolore magna aliqua. 
                Ut enim ad minim veniam, quis nostrud exercitation ullamco 
                laboris nisi ut aliquip ex ea commodo consequat. Duis aute 
                irure dolor in reprehenderit in voluptate velit esse cillum 
                dolore eu fugiat nulla pariatur. Excepteur sint occaecat 
                cupidatat non proident, sunt in culpa qui officia deserunt 
                mollit anim id est laborum."->React.string}
              </p>
            )->React.array}
          </div>
          <Sheet.Footer>
            <Button type_="submit"> {"Save changes"->React.string} </Button>
            <Sheet.Close> {"Cancel"->React.string} </Sheet.Close>
          </Sheet.Footer>
        </Sheet>
      </Sheet.Trigger>
    )
    ->React.array}
  </div>
