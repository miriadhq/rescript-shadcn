@@directive("'use client'")

module RT = DataTableDemo.RT

@react.component
let make = (~table: RT.t<'data>) => {
  <DropdownMenu>
    <DropdownMenu.Trigger
      render={<Button variant=Outline size=Sm className="ml-auto hidden h-8 lg:flex" />}
    >
      <Icons.Settings2 />
      {"View"->React.string}
    </DropdownMenu.Trigger>
    <DropdownMenu.Content align=End className="w-[150px]">
      <DropdownMenu.Label> {"Toggle columns"->React.string} </DropdownMenu.Label>
      <DropdownMenu.Separator />
      <DropdownMenu.Group>
        {table
        ->RT.getAllColumns
        ->Array.filter(col => col->RT.colGetCanHide)
        ->Array.map(col =>
          <DropdownMenu.CheckboxItem
            key={col->RT.colId}
            className="capitalize"
            checked={col->RT.colGetIsVisible}
            onCheckedChange={(v, _) => col->RT.colToggleVisibility(v)}
          >
            {col->RT.colId->React.string}
          </DropdownMenu.CheckboxItem>
        )
        ->React.array}
      </DropdownMenu.Group>
    </DropdownMenu.Content>
  </DropdownMenu>
}
