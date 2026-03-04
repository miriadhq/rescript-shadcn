@@directive("'use client'")

@react.component
let make = () =>
  <div className="grid w-full max-w-sm gap-4">
    <InputGroup>
      <InputGroup.Input placeholder="Enter file name" />
      <InputGroup.Addon align=InlineEnd>
        <DropdownMenu>
          <DropdownMenu.Trigger
            render={<InputGroup.Button variant=Ghost ariaLabel="More" size=IconXs />}
          >
            <Icons.MoreHorizontal />
          </DropdownMenu.Trigger>
          <DropdownMenu.Content align=BaseUi.Types.Align.End sideOffset=8. alignOffset={-4.}>
            <DropdownMenu.Group>
              <DropdownMenu.Item> {"Settings"->React.string} </DropdownMenu.Item>
              <DropdownMenu.Item> {"Copy path"->React.string} </DropdownMenu.Item>
              <DropdownMenu.Item> {"Open location"->React.string} </DropdownMenu.Item>
            </DropdownMenu.Group>
          </DropdownMenu.Content>
        </DropdownMenu>
      </InputGroup.Addon>
    </InputGroup>
    <InputGroup>
      <InputGroup.Input placeholder="Enter search query" />
      <InputGroup.Addon align=InlineEnd>
        <DropdownMenu>
          <DropdownMenu.Trigger
            render={<InputGroup.Button variant=Ghost className="!pr-1.5 text-xs" />}
          >
            {"Search In..."->React.string}
            <Icons.ChevronDown className="size-3" />
          </DropdownMenu.Trigger>
          <DropdownMenu.Content align=BaseUi.Types.Align.End sideOffset=8. alignOffset={-4.}>
            <DropdownMenu.Group>
              <DropdownMenu.Item> {"Documentation"->React.string} </DropdownMenu.Item>
              <DropdownMenu.Item> {"Blog Posts"->React.string} </DropdownMenu.Item>
              <DropdownMenu.Item> {"Changelog"->React.string} </DropdownMenu.Item>
            </DropdownMenu.Group>
          </DropdownMenu.Content>
        </DropdownMenu>
      </InputGroup.Addon>
    </InputGroup>
  </div>
