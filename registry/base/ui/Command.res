@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

@@directive("'use client'")

open BaseUi.Types

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

module CommandPrimitive = {
  type props<'value, 'checked> = {
    ...props<'value, 'checked>,
    defaultValue?: 'value,
  }
  @module("cmdk")
  external make: React.component<props<'value, 'checked>> = "Command"

  module Input = {
    @module("cmdk") @scope("Command")
    external make: React.component<props<'value, 'checked>> = "Input"
  }

  module List = {
    @module("cmdk") @scope("Command")
    external make: React.component<props<'value, 'checked>> = "List"
  }

  module Empty = {
    @module("cmdk") @scope("Command")
    external make: React.component<props<'value, 'checked>> = "Empty"
  }

  module Group = {
    @module("cmdk") @scope("Command")
    external make: React.component<props<'value, 'checked>> = "Group"
  }

  module Separator = {
    @module("cmdk") @scope("Command")
    external make: React.component<props<'value, 'checked>> = "Separator"
  }

  module Item = {
    @module("cmdk") @scope("Command")
    external make: React.component<props<'value, 'checked>> = "Item"
  }
}

@react.component
let make = (
  ~className=?,
  ~children=?,
  ~id=?,
  ~style=?,
  ~onClick=?,
  ~onKeyDown=?,
  ~value=?,
  ~defaultValue=?,
  ~onValueChange=?,
  ~dir=?,
) =>
  <CommandPrimitive
    ?id
    ?style
    ?onClick
    ?onKeyDown
    ?value
    ?defaultValue
    ?onValueChange
    ?dir
    dataSlot="command"
    className={cn(
      "flex size-full flex-col overflow-hidden rounded-xl! bg-popover p-1 text-popover-foreground",
      className,
    )}
    ?children
  />

module Dialog = {
  @react.component
  let make = (
    ~className=?,
    ~children=React.null,
    ~open_=?,
    ~defaultOpen=?,
    ~onOpenChange=?,
    ~onOpenChangeComplete=?,
    ~modal=?,
    ~title="Command Palette",
    ~description="Search for a command to run...",
    ~showCloseButton=false,
  ) =>
    <Dialog ?open_ ?defaultOpen ?onOpenChange ?onOpenChangeComplete ?modal>
      <Dialog.Header className="sr-only">
        <Dialog.Title> {title->React.string} </Dialog.Title>
        <Dialog.Description> {description->React.string} </Dialog.Description>
      </Dialog.Header>
      <Dialog.Content
        className={cn("top-1/3 translate-y-0 overflow-hidden rounded-xl! p-0", className)}
        showCloseButton
      >
        {children}
      </Dialog.Content>
    </Dialog>
}

module Input = {
  @react.component
  let make = (
    ~className=?,
    ~children=?,
    ~id=?,
    ~style=?,
    ~value=?,
    ~defaultValue=?,
    ~onValueChange=?,
    ~onClick=?,
    ~onKeyDown=?,
    ~placeholder=?,
    ~dir=?,
  ) => {
    <div dataSlot="command-input-wrapper" className="p-1 pb-0">
      <InputGroup
        className="h-8! rounded-lg! border-input/30 bg-input/30 shadow-none! *:data-[slot=input-group-addon]:pl-2!"
      >
        <CommandPrimitive.Input
          ?id
          ?style
          ?value
          ?defaultValue
          ?onValueChange
          ?onClick
          ?onKeyDown
          ?placeholder
          ?dir
          ?children
          dataSlot="command-input"
          className={cn(
            "w-full text-sm outline-hidden disabled:cursor-not-allowed disabled:opacity-50",
            className,
          )}
        />
        <InputGroup.Addon>
          <Icons.Search className="size-4 shrink-0 opacity-50" />
        </InputGroup.Addon>
      </InputGroup>
    </div>
  }
}

module List = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <CommandPrimitive.List
      ?id
      ?style
      ?onClick
      ?onKeyDown
      dataSlot="command-list"
      className={cn(
        "no-scrollbar max-h-72 scroll-py-1 overflow-x-hidden overflow-y-auto outline-none",
        className,
      )}
      ?children
    />
}

module Empty = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?) =>
    <CommandPrimitive.Empty
      ?id
      ?style
      dataSlot="command-empty"
      className={cn("py-6 text-center text-sm", className)}
      ?children
    />
}

module Group = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~heading=?) =>
    <CommandPrimitive.Group
      ?id
      ?style
      ?heading
      dataSlot="command-group"
      className={cn(
        "text-foreground **:[[cmdk-group-heading]]:text-muted-foreground overflow-hidden p-1 **:[[cmdk-group-heading]]:px-2 **:[[cmdk-group-heading]]:py-1.5 **:[[cmdk-group-heading]]:text-xs **:[[cmdk-group-heading]]:font-medium",
        className,
      )}
      ?children
    />
}

module Separator = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?) =>
    <CommandPrimitive.Separator
      ?id
      ?style
      ?children
      dataSlot="command-separator"
      className={cn("bg-border -mx-1 h-px", className)}
    />
}

module Item = {
  @react.component
  let make = (
    ~className=?,
    ~children=React.null,
    ~id=?,
    ~style=?,
    ~value=?,
    ~onSelect=?,
    ~disabled=?,
    ~onClick=?,
    ~onKeyDown=?,
  ) =>
    <CommandPrimitive.Item
      ?id
      ?style
      ?value
      ?onSelect
      ?disabled
      ?onClick
      ?onKeyDown
      dataSlot="command-item"
      className={cn(
        "data-selected:bg-muted data-selected:text-foreground data-selected:*:[svg]:text-foreground group/command-item relative flex cursor-default items-center gap-2 rounded-sm px-2 py-1.5 text-sm outline-hidden select-none in-data-[slot=dialog-content]:rounded-lg! data-[disabled=true]:pointer-events-none data-[disabled=true]:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-4",
        className,
      )}
    >
      {children}
      <Icons.Check
        className="ml-auto opacity-0 group-has-data-[slot=command-shortcut]/command-item:hidden group-data-[checked=true]/command-item:opacity-100"
      />
    </CommandPrimitive.Item>
}

module Shortcut = {
  @react.component
  let make = (~className=?, ~children=?, ~id=?, ~style=?, ~onClick=?, ~onKeyDown=?) =>
    <span
      ?id
      ?style
      ?children
      ?onClick
      ?onKeyDown
      dataSlot="command-shortcut"
      className={cn(
        "text-muted-foreground group-data-selected/command-item:text-foreground ml-auto text-xs tracking-widest",
        className,
      )}
    />
}
