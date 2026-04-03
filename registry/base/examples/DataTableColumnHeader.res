module RT = DataTableDemo.RT

@send external colGetCanSort: RT.col => bool = "getCanSort"

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

@react.component
let make = (~column: RT.col, ~title: string, ~className="") => {
  if !(column->colGetCanSort) {
    <div className={cn("", Some(className))}> {title->React.string} </div>
  } else {
    let sorted = column->RT.colGetIsSorted
    <div className={cn("flex items-center gap-2", Some(className))}>
      <DropdownMenu>
        <DropdownMenu.Trigger
          render={<Button
            variant=Ghost size=Sm className="-ml-3 h-8 data-[state=open]:bg-accent"
          />}
        >
          <span> {title->React.string} </span>
          {if sorted == "desc" {
            <Icons.ArrowDown />
          } else if sorted == "asc" {
            <Icons.ArrowUp />
          } else {
            <Icons.ChevronsUpDown />
          }}
        </DropdownMenu.Trigger>
        <DropdownMenu.Content align=Start>
          <DropdownMenu.Item onClick={_ => column->RT.colToggleSorting(false)}>
            <Icons.ArrowUp />
            {"Asc"->React.string}
          </DropdownMenu.Item>
          <DropdownMenu.Item onClick={_ => column->RT.colToggleSorting(true)}>
            <Icons.ArrowDown />
            {"Desc"->React.string}
          </DropdownMenu.Item>
          <DropdownMenu.Separator />
          <DropdownMenu.Item onClick={_ => column->RT.colToggleVisibility(false)}>
            <Icons.EyeOff />
            {"Hide"->React.string}
          </DropdownMenu.Item>
        </DropdownMenu.Content>
      </DropdownMenu>
    </div>
  }
}
