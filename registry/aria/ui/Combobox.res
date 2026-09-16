@@directive("'use client'")

@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

@module("cn")
external cn: (string, option<string>) => string = "cn"

type rootProps<'item, 'value> = ReactAria.Combobox.props<'item, 'value>

@react.componentWithProps(rootProps)
let make = (props: rootProps<'item, 'value>) => <ReactAria.Combobox {...props} />

module Value = {
  @react.componentWithProps(ReactAria.Combobox.Value.props)
  let make = (props: ReactAria.Combobox.Value.props<'item, 'value>) => {
    let dataSlot = props.dataSlot->Option.getOr("combobox-value")
    <ReactAria.Combobox.Value {...props} dataSlot />
  }
}

module Trigger = {
  @react.componentWithProps(ReactAria.Button.props)
  let make = (props: ReactAria.Button.props) => {
    let dataSlot = props.dataSlot->Option.getOr("combobox-trigger")
    <ReactAria.Button {...props} dataSlot className={cn("cn-combobox-trigger", props.className)}>
      {props.children->Option.getOr(React.null)}
      <Icons.ChevronDown className="cn-combobox-trigger-icon pointer-events-none" />
    </ReactAria.Button>
  }
}

module Clear = {
  let noSlot: string = %raw(`null`)

  @react.componentWithProps(InputGroup.Button.props)
  let make = (props: InputGroup.Button.props) => {
    let dataSlot = props.dataSlot->Option.getOr("combobox-clear")
    let state = React.useContext(ReactAria.Combobox.stateContext)
    switch state {
    | Null | Undefined => React.null
    | Value(state) if state.inputValue == "" => React.null
    | Value(state) =>
      <InputGroup.Button
        {...props}
        dataSlot
        variant={props.variant->Option.getOr(Ghost)}
        size={props.size->Option.getOr(IconXs)}
        ariaLabel={props.ariaLabel->Option.getOr("Clear")}
        className={cn("cn-combobox-clear", props.className)}
        onPress={props.onPress->Option.getOr(_ => state.setValue(Null))}
        slot=noSlot
      >
        <Icons.X className="cn-combobox-clear-icon pointer-events-none" />
      </InputGroup.Button>
    }
  }
}

module Input = {
  type props = {
    showTrigger?: bool,
    showClear?: bool,
    ...ReactAria.Input.props,
  }

  let inputProps: props => ReactAria.Input.props = %raw(`({className, children, showTrigger, showClear, ...props}) => props`)

  @react.componentWithProps(props)
  let make = (props: props) => {
    let disabled = props.disabled->Option.getOr(false)
    let showTrigger = props.showTrigger->Option.getOr(true)
    let showClear = props.showClear->Option.getOr(false)
    <InputGroup className={cn("cn-combobox-input w-auto", props.className)}>
      <InputGroup.Input {...props->inputProps} disabled />
      <InputGroup.Addon align=InlineEnd>
        {showTrigger
          ? <InputGroup.Button
              size=IconXs
              variant=Ghost
              dataSlot="combobox-trigger"
              className="cn-combobox-trigger group-has-data-[slot=combobox-clear]/input-group:hidden data-pressed:bg-transparent"
              isDisabled=disabled
            >
              <Icons.ChevronDown className="cn-combobox-trigger-icon pointer-events-none" />
            </InputGroup.Button>
          : React.null}
        {showClear ? <Clear isDisabled=disabled /> : React.null}
      </InputGroup.Addon>
      {props.children->Option.getOr(React.null)}
    </InputGroup>
  }
}

module Content = {
  type props = {anchor?: ReactDOM.domRef, ...ReactAria.Popover.props}
  let popoverProps: props => ReactAria.Popover.props = %raw(`({anchor, ...props}) => props`)

  @react.componentWithProps(props)
  let make = (props: props) => {
    let dataSlot = props.dataSlot->Option.getOr("combobox-content")
    <ReactAria.Popover
      {...props->popoverProps}
      dataSlot
      triggerRef=?{props.anchor}
      placement={props.placement->Option.getOr(ReactAria.Common.Bottom)}
      offset={props.offset->Option.getOr(6.)}
      crossOffset={props.crossOffset->Option.getOr(0.)}
      className={cn(
        "cn-combobox-content-aria cn-menu-target cn-menu-translucent cn-menu-translucent-aria relative isolate z-50 w-(--trigger-width) origin-(--trigger-anchor-point)",
        props.className,
      )}
    />
  }
}

module List = {
  @react.componentWithProps(ReactAria.Combobox.List.props)
  let make = (props: ReactAria.Combobox.List.props<'item>) => {
    let dataSlot = props.dataSlot->Option.getOr("combobox-list")
    <ReactAria.Combobox.List
      {...props}
      dataSlot
      className={cn(
        "cn-combobox-list group/combobox-content max-h-[inherit] overflow-y-auto overscroll-contain",
        props.className,
      )}
    />
  }
}

let textValueFromChildren: option<React.element> => option<string> = %raw(`children =>
  typeof children === "string" ? children : undefined
`)

module Item = {
  @react.componentWithProps(ReactAria.Combobox.Item.props)
  let make = (props: ReactAria.Combobox.Item.props<'item, 'key>) => {
    let dataSlot = props.dataSlot->Option.getOr("combobox-item")
    let textValue = props.textValue->Option.orElse(textValueFromChildren(props.children))
    let children = ReactAria.Common.composeItemRenderProps(props.children, (
      children,
      {isSelected},
    ) =>
      <>
        {children}
        <span className="cn-combobox-item-indicator">
          {isSelected
            ? <Icons.Check className="cn-combobox-item-indicator-icon pointer-events-none" />
            : React.null}
        </span>
      </>
    )
    <ReactAria.Combobox.Item
      {...props}
      ?textValue
      dataSlot
      className={cn(
        "cn-combobox-item cn-combobox-item-aria relative flex w-full cursor-default items-center outline-hidden select-none data-disabled:pointer-events-none data-disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0",
        props.className,
      )}
      children
    />
  }
}

module Group = {
  @react.componentWithProps(ReactAria.Combobox.Group.props)
  let make = (props: ReactAria.Combobox.Group.props<'item, 'children>) => {
    let dataSlot = props.dataSlot->Option.getOr("combobox-group")
    <ReactAria.Combobox.Group
      {...props} dataSlot className={cn("cn-combobox-group", props.className)}
    />
  }
}

module Label = {
  @react.componentWithProps(ReactAria.Header.props)
  let make = (props: ReactAria.Header.props) => {
    let dataSlot = props.dataSlot->Option.getOr("combobox-label")
    <ReactAria.Header {...props} dataSlot className={cn("cn-combobox-label", props.className)} />
  }
}

module Collection = {
  @react.componentWithProps(ReactAria.Combobox.Collection.props)
  let make = (props: ReactAria.Combobox.Collection.props<'item>) =>
    <ReactAria.Combobox.Collection {...props} />
}

module Empty = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) => {
    let dataSlot = props.dataSlot->Option.getOr("combobox-empty")
    <div {...props} dataSlot className={cn("cn-combobox-empty", props.className)} />
  }
}

module Separator = {
  @react.componentWithProps(ReactAria.Separator.props)
  let make = (props: ReactAria.Separator.props) => {
    let dataSlot = props.dataSlot->Option.getOr("combobox-separator")
    <ReactAria.Separator
      {...props} dataSlot className={cn("cn-combobox-separator", props.className)}
    />
  }
}

module Chips = {
  @react.componentWithProps(ReactAria.Group.props)
  let make = (props: ReactAria.Group.props) => {
    let dataSlot = props.dataSlot->Option.getOr("combobox-chips")
    <ReactAria.Group {...props} dataSlot className={cn("cn-combobox-chips", props.className)} />
  }
}

module ChipList = {
  @react.componentWithProps(ReactAria.TagGroup.List.props)
  let make = (props: ReactAria.TagGroup.List.props<'item>) =>
    <ReactAria.Combobox.Value
      className="contents"
      children={state => {
        let selectedItems = state.selectedItems->Array.filterMap(Null.toOption)
        <ReactAria.TagGroup
          dataSlot="combobox-chip-list"
          className={cn("contents", props.className)}
          onRemove={keys => {
            let value = state.state.value->Array.filter(key => keys->Set.has(key) == false)
            state.state.setValue(value->Nullable.make)
          }}
        >
          <ReactAria.TagGroup.List {...props} className="contents" items={selectedItems} />
        </ReactAria.TagGroup>
      }}
    />
}

module Chip = {
  type props = {showRemove?: bool, ...ReactAria.TagGroup.Item.props}
  let itemProps: props => ReactAria.TagGroup.Item.props = %raw(`({showRemove, ...props}) => props`)

  @react.componentWithProps(props)
  let make = (props: props) => {
    let dataSlot = props.dataSlot->Option.getOr("combobox-chip")
    <ReactAria.TagGroup.Item
      {...props->itemProps}
      dataSlot
      className={cn(
        "cn-combobox-chip has-disabled:pointer-events-none has-disabled:cursor-not-allowed has-disabled:opacity-50",
        props.className,
      )}
    >
      {props.children->Option.getOr(React.null)}
      {props.showRemove->Option.getOr(true)
        ? <Button
            slot="remove"
            variant=Ghost
            size=IconXs
            className="cn-combobox-chip-remove"
            dataSlot="combobox-chip-remove"
          >
            <Icons.X className="cn-combobox-chip-indicator-icon pointer-events-none" />
          </Button>
        : React.null}
    </ReactAria.TagGroup.Item>
  }
}

@get external keyboardKey: JsxEvent.Keyboard.t => string = "key"
@send external preventDefault: JsxEvent.Keyboard.t => unit = "preventDefault"
let currentTargetValue: JsxEvent.Keyboard.t => string = %raw(`event => event.currentTarget.value`)

module ChipsInput = {
  @react.componentWithProps(ReactAria.Input.props)
  let make = (props: ReactAria.Input.props) => {
    let dataSlot = props.dataSlot->Option.getOr("combobox-chip-input")
    let state: nullable<ReactAria.Combobox.state<array<string>>> = React.useContext(
      ReactAria.Combobox.stateContext,
    )
    let onKeyDown = props.onKeyDown->Option.getOr(event => {
      if event->keyboardKey == "Backspace" && event->currentTargetValue == "" {
        switch state {
        | Value(state) if state.value->Array.length > 0 => {
            event->preventDefault
            state.setValue(state.value->Array.slice(~start=0, ~end=-1)->Nullable.make)
          }
        | _ => ()
        }
      }
    })
    <ReactAria.Input
      {...props}
      dataSlot
      className={cn("cn-combobox-chip-input min-w-16 flex-1 outline-none", props.className)}
      onKeyDown
    />
  }
}

let useAnchor = () => React.useRef(null)->ReactDOM.Ref.domRef
