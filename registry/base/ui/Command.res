@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

@@directive("'use client'")

open BaseUi.Types

@module("cn")
external cn: (string, option<string>) => string = "cn"

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
      ...BaseUi.Types.BaseDomWithoutOnSelectProps.t,
      ...BaseUi.Types.ExtraDomProps.t,
      children?: React.element,
      value?: string,
      onSelect?: string => unit,
      asChild?: bool,
      keywords?: array<string>,
      forceMount?: bool,
    }
    @module("cmdk") @scope("Command")
    external make: React.component<props> = "Item"
  }
}

@react.componentWithProps(CommandPrimitive.props)
let make = (props: CommandPrimitive.props) =>
  <CommandPrimitive
    {...props}
    dataSlot={props.dataSlot->Option.getOr("command")}
    className={cn("cn-command flex size-full flex-col overflow-hidden", props.className)}
  />

module Dialog = {
  type props<'payload> = {
    ...BaseUi.Dialog.Root.props<'payload>,
    description?: string,
    showCloseButton?: bool,
  }

  let toBaseUiProps: props<'payload> => BaseUi.Dialog.Root.props<
    'payload,
  > = %raw(`({className, title, description, showCloseButton, ...props}) => props`)

  @react.componentWithProps(props)
  let make = (props: props<'payload>) => {
    let children = props.children->Option.getOr(React.null)
    let title = props.title->Option.getOr("Command Palette")
    let description = props.description->Option.getOr("Search for a command to run...")
    let showCloseButton = props.showCloseButton->Option.getOr(false)
    <Dialog {...props->toBaseUiProps}>
      <Dialog.Header className="sr-only">
        <Dialog.Title> {title->React.string} </Dialog.Title>
        <Dialog.Description> {description->React.string} </Dialog.Description>
      </Dialog.Header>
      <Dialog.Content
        className={cn(
          "cn-command-dialog top-1/3 translate-y-0 overflow-hidden p-0",
          props.className,
        )}
        showCloseButton
      >
        {children}
      </Dialog.Content>
    </Dialog>
  }
}

module Input = {
  @react.componentWithProps(CommandPrimitive.Input.props)
  let make = (props: CommandPrimitive.Input.props) =>
    <div dataSlot="command-input-wrapper" className="cn-command-input-wrapper">
      <InputGroup className="cn-command-input-group">
        <CommandPrimitive.Input
          {...props}
          dataSlot={props.dataSlot->Option.getOr("command-input")}
          className={cn(
            "cn-command-input outline-hidden disabled:cursor-not-allowed disabled:opacity-50",
            props.className,
          )}
        />
        <InputGroup.Addon>
          <Icons.Search className="cn-command-input-icon" />
        </InputGroup.Addon>
      </InputGroup>
    </div>
}

module List = {
  @react.componentWithProps(BaseUi.Types.BaseUIComponentProps.t)
  let make = (props: BaseUi.Types.BaseUIComponentProps.t) =>
    <CommandPrimitive.List
      {...props}
      dataSlot={props.dataSlot->Option.getOr("command-list")}
      className={cn("cn-command-list overflow-x-hidden overflow-y-auto", props.className)}
    />
}

module Empty = {
  @react.componentWithProps(BaseUi.Types.BaseUIComponentProps.t)
  let make = (props: BaseUi.Types.BaseUIComponentProps.t) =>
    <CommandPrimitive.Empty
      {...props}
      dataSlot={props.dataSlot->Option.getOr("command-empty")}
      className={cn("cn-command-empty", props.className)}
    />
}

module Group = {
  @react.componentWithProps(CommandPrimitive.Group.props)
  let make = (props: CommandPrimitive.Group.props) =>
    <CommandPrimitive.Group
      {...props}
      dataSlot={props.dataSlot->Option.getOr("command-group")}
      className={cn("cn-command-group", props.className)}
    />
}

module Separator = {
  @react.componentWithProps(CommandPrimitive.Separator.props)
  let make = (props: CommandPrimitive.Separator.props) =>
    <CommandPrimitive.Separator
      {...props}
      dataSlot={props.dataSlot->Option.getOr("command-separator")}
      className={cn("cn-command-separator", props.className)}
    />
}

module Item = {
  @react.componentWithProps(CommandPrimitive.Item.props)
  let make = (props: CommandPrimitive.Item.props) => {
    let children = props.children->Option.getOr(React.null)
    <CommandPrimitive.Item
      {...props}
      dataSlot={props.dataSlot->Option.getOr("command-item")}
      className={cn(
        "cn-command-item group/command-item data-[disabled=true]:pointer-events-none data-[disabled=true]:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0",
        props.className,
      )}
    >
      {children}
      <Icons.Check
        className="cn-command-item-indicator ml-auto opacity-0 group-has-data-[slot=command-shortcut]/command-item:hidden group-data-[checked=true]/command-item:opacity-100"
      />
    </CommandPrimitive.Item>
  }
}

module Shortcut = {
  @react.componentWithProps(BaseUi.Types.DomProps.t)
  let make = (props: BaseUi.Types.DomProps.t) =>
    <span
      {...props}
      dataSlot={props.dataSlot->Option.getOr("command-shortcut")}
      className={cn("cn-command-shortcut", props.className)}
    />
}
