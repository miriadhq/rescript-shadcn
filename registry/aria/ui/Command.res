@@directive("'use client'")

@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

type props = {...ReactAria.Autocomplete.props}

@warning("-112") @react.componentWithProps(props)
let make = ({?className, ?dir, ?style, ...ReactAria.Autocomplete.props as props}) => {
  let contains = ReactAria.Autocomplete.useFilter({sensitivity: "base"}).contains
  <div
    dataSlot="command"
    ?dir
    ?style
    className={cn("cn-command flex size-full flex-col overflow-hidden", className)}
  >
    <ReactAria.Autocomplete
      {...props} className=?None style=?None dir=?None filter={props.filter->Option.getOr(contains)}
    >
      {props.children->Option.getOr(React.null)}
    </ReactAria.Autocomplete>
  </div>
}

module Dialog = {
  type props = {title?: string, description?: string, open_?: bool, ...Dialog.props}

  @warning("-112") @react.componentWithProps(props)
  let make = ({?title, ?description, ?open_, ?className, ?children, ...Dialog.props as props}) =>
    <Dialog
      {...props}
      isOpen=?open_
      className={cn("cn-command-dialog top-1/3 translate-y-0 overflow-hidden p-0", className)}
      showCloseButton={props.showCloseButton->Option.getOr(false)}
      isDismissable=true
    >
      <Dialog.Header className="sr-only">
        <Dialog.Title> {title->Option.getOr("Command Palette")->React.string} </Dialog.Title>
        <Dialog.Description>
          {description->Option.getOr("Search for a command to run...")->React.string}
        </Dialog.Description>
      </Dialog.Header>
      {children->Option.getOr(React.null)}
    </Dialog>
}

module Input = {
  @react.componentWithProps(ReactAria.Input.props)
  let make = (props: ReactAria.Input.props) =>
    <ReactAria.SearchField
      autoFocus=true
      ariaLabel={props.placeholder->Option.getOr("Search")}
      dataSlot="command-input-wrapper"
      className="cn-command-input-wrapper"
    >
      <InputGroup className="cn-command-input-group">
        <ReactAria.Input
          {...props}
          dataSlot="command-input"
          className={cn(
            "cn-command-input outline-hidden disabled:cursor-not-allowed disabled:opacity-50 [&::-webkit-search-cancel-button]:hidden",
            props.className,
          )}
        />
        <InputGroup.Addon>
          <Icons.Search className="cn-command-input-icon" />
        </InputGroup.Addon>
      </InputGroup>
    </ReactAria.SearchField>
}

module List = {
  type props<'item> = {...ReactAria.Menu.props<'item>}

  @react.componentWithProps(props)
  let make = ({...ReactAria.Menu.props as props}) =>
    <ReactAria.Menu
      {...props}
      dataSlot="command-list"
      className={cn("cn-command-list overflow-x-hidden overflow-y-auto", props.className)}
    />
}

module Empty = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) =>
    <div {...props} dataSlot="command-empty" className={cn("cn-command-empty", props.className)} />
}

module Group = {
  type props<'item> = {
    heading?: string,
    ...ReactAria.Menu.Section.props<'item>,
  }
  @react.componentWithProps(props)
  let make = ({?heading, ...ReactAria.Menu.Section.props as props}) =>
    <ReactAria.Menu.Section
      {...props} dataSlot="command-group" className={cn("cn-command-group", props.className)}
    >
      {switch heading {
      | Some(heading) =>
        <ReactAria.Header cmdkGroupHeading=""> {heading->React.string} </ReactAria.Header>
      | None => React.null
      }}
      <ReactAria.Combobox.Collection.Flexible items=?props.items children=?props.children />
    </ReactAria.Menu.Section>
}

module Separator = {
  @react.componentWithProps(ReactAria.Separator.props)
  let make = (props: ReactAria.Separator.props) =>
    <ReactAria.Separator
      {...props}
      dataSlot="command-separator"
      className={cn("cn-command-separator", props.className)}
    />
}

let textValueFromChildren: option<React.element> => option<string> = %raw(`children =>
  typeof children === "string" ? children : undefined
`)

module Item = {
  type props<'item> = {...ReactAria.Menu.Item.props<'item>}

  @react.componentWithProps(props)
  let make = ({...ReactAria.Menu.Item.props as props}) => {
    let textValue = props.textValue->Option.orElse(textValueFromChildren(props.children))
    let children = ReactAria.Common.composeItemRenderProps(props.children, (children, _) =>
      <>
        {children}
        <Icons.Check
          className="cn-command-item-indicator ml-auto opacity-0 group-has-data-[slot=command-shortcut]/command-item:hidden group-data-[checked=true]/command-item:opacity-100"
        />
      </>
    )
    <ReactAria.Menu.Item
      {...props}
      ?textValue
      dataSlot="command-item"
      className={cn(
        "cn-command-item cn-command-item-aria group/command-item data-[disabled=true]:pointer-events-none data-[disabled=true]:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0",
        props.className,
      )}
      children
    />
  }
}

module Shortcut = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) =>
    <span
      {...props}
      dataSlot="command-shortcut"
      className={cn("cn-command-shortcut cn-command-shortcut-aria", props.className)}
    />
}
