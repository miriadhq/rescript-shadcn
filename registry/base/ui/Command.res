@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

@@directive("'use client'")

open BaseUi.Types

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

module CommandPrimitive = {
  type props = {
    ...BaseUIComponentProps.t,
    value?: string,
    onValueChange?: string => unit,
    defaultValue?: string,
  }
  @module("cmdk")
  external make: React.component<props> = "Command"

  module Input = {
    type props = {
      ...BaseUIComponentProps.t,
      value?: string,
      onValueChange?: string => unit,
      defaultValue?: string,
    }
    @module("cmdk") @scope("Command")
    external make: React.component<props> = "Input"
  }

  module List = {
    @module("cmdk") @scope("Command")
    external make: React.component<BaseUIComponentProps.t> = "List"
  }

  module Empty = {
    @module("cmdk") @scope("Command")
    external make: React.component<BaseUIComponentProps.t> = "Empty"
  }

  module Group = {
    type props = {
      ...BaseUIComponentProps.t,
      heading?: string,
      forceMount?: bool,
    }
    @module("cmdk") @scope("Command")
    external make: React.component<props> = "Group"
  }

  module Separator = {
    type props = {
      ...BaseUIComponentProps.t,
      alwaysRender?: bool,
    }
    @module("cmdk") @scope("Command")
    external make: React.component<props> = "Separator"
  }

  module Item = {
    type props = {
      children?: React.element,
      className?: string,
      id?: string,
      style?: ReactDOM.Style.t,
      value?: string,
      onSelect?: string => unit,
      disabled?: bool,
      onClick?: JsxEvent.Mouse.t => unit,
      onKeyDown?: JsxEvent.Keyboard.t => unit,
      dataSlot?: string,
      ref?: ReactDOM.domRef,
      asChild?: bool,
    }
    @module("cmdk") @scope("Command")
    external make: React.component<props> = "Item"
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
      "cn-command flex size-full flex-col overflow-hidden",
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
        className={cn("cn-command-dialog top-1/3 translate-y-0 overflow-hidden p-0", className)}
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
    <div dataSlot="command-input-wrapper" className="cn-command-input-wrapper">
      <InputGroup
        className="cn-command-input-group"
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
            "cn-command-input outline-hidden disabled:cursor-not-allowed disabled:opacity-50",
            className,
          )}
        />
        <InputGroup.Addon>
          <Icons.Search className="cn-command-input-icon" />
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
        "cn-command-list overflow-x-hidden overflow-y-auto",
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
      className={cn("cn-command-empty", className)}
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
        "cn-command-group",
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
      className={cn("cn-command-separator", className)}
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
        "cn-command-item group/command-item data-[disabled=true]:pointer-events-none data-[disabled=true]:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0",
        className,
      )}
    >
      {children}
      <Icons.Check
        className="cn-command-item-indicator ml-auto opacity-0 group-has-data-[slot=command-shortcut]/command-item:hidden group-data-[checked=true]/command-item:opacity-100"
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
        "cn-command-shortcut",
        className,
      )}
    />
}
