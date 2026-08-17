/** Shared React Aria component types, grounded in react-aria-components 1.19.0. */
module Orientation = {
  @unboxed
  type t =
    | @as("horizontal") Horizontal
    | @as("vertical") Vertical
}

module SelectionMode = {
  @unboxed
  type t =
    | @as("single") Single
    | @as("multiple") Multiple
}

module ItemSelectionMode = {
  @unboxed
  type t =
    | @as("none") None
    | @as("single") Single
    | @as("multiple") Multiple
}

module SelectionBehavior = {
  @unboxed
  type t =
    | @as("toggle") Toggle
    | @as("replace") Replace
}

module DisabledBehavior = {
  @unboxed
  type t =
    | @as("all") All
    | @as("selection") Selection
}

module AutoFocus = {
  @unboxed
  type t =
    | Bool(bool)
    | @as("first") First
    | @as("last") Last
}

module EscapeKeyBehavior = {
  @unboxed
  type t =
    | @as("clearSelection") ClearSelection
    | @as("none") None
}

module Placement = {
  @unboxed
  type t =
    | @as("top") Top
    | @as("bottom") Bottom
    | @as("left") Left
    | @as("right") Right
    | @as("top start") TopStart
    | @as("top end") TopEnd
    | @as("bottom start") BottomStart
    | @as("bottom end") BottomEnd
    | @as("bottom left") BottomLeft
    | @as("bottom right") BottomRight
    | @as("top left") TopLeft
    | @as("top right") TopRight
    | @as("left top") LeftTop
    | @as("left bottom") LeftBottom
    | @as("right top") RightTop
    | @as("right bottom") RightBottom
    | @as("start") Start
    | @as("start top") StartTop
    | @as("start bottom") StartBottom
    | @as("end") End
    | @as("end top") EndTop
    | @as("end bottom") EndBottom
}

module PressEvent = {
  type t
}

module Key = {
  type t = string
}

module Selection = {
  @unboxed
  type t =
    | @as("all") All
    | Keys(Set.t<Key.t>)
}

module RenderState = {
  type t = {
    isDisabled?: bool,
    isSelected?: bool,
    isIndeterminate?: bool,
    isPressed?: bool,
    isHovered?: bool,
    isFocused?: bool,
    isFocusVisible?: bool,
    isOpen?: bool,
    isExpanded?: bool,
    isInvalid?: bool,
    isEmpty?: bool,
  }
}

/**
 * The state passed to the render-function form of collection item children.
 *
 * React Aria models `children` as a TypeScript union of a React node and a
 * callback. `composeItemRenderProps` exposes the callback form without a props
 * conversion helper.
 */
module ItemRenderProps = {
  type t = {
    defaultChildren?: React.element,
    isHovered: bool,
    isPressed: bool,
    isSelected: bool,
    isFocused: bool,
    isFocusVisible: bool,
    isDisabled: bool,
    selectionMode: ItemSelectionMode.t,
    selectionBehavior: string,
    allowsDragging?: bool,
    isDragging?: bool,
    isDropTarget?: bool,
  }
}

@module("react-aria-components")
external composeRenderProps: (
  option<'children>,
  (React.element, 'renderProps) => React.element,
) => 'renderProps => React.element = "composeRenderProps"

@module("react-aria-components")
external composeRenderElement: (
  option<React.element>,
  (React.element, 'renderProps) => React.element,
) => React.element = "composeRenderProps"

/**
 * `composeRenderProps` returns a function, which is also a valid React child at
 * runtime. This declaration keeps that zero-cost representation usable by
 * collection components whose bindings expose `children` as `React.element`.
 */
@module("react-aria-components")
external composeItemRenderProps: (
  option<React.element>,
  (React.element, ItemRenderProps.t) => React.element,
) => React.element = "composeRenderProps"

module BaseProps = {
  type t = {
    key?: string,
    ref?: ReactDOM.domRef,
    className?: string,
    id?: string,
    style?: ReactDOM.Style.t,
    dir?: string,
    role?: string,
    slot?: string,
    tabIndex?: int,
    hidden?: bool,
    suppressHydrationWarning?: bool,
    onClick?: JsxEvent.Mouse.t => unit,
    onKeyDown?: JsxEvent.Keyboard.t => unit,
    onKeyDownCapture?: JsxEvent.Keyboard.t => unit,
    onBlur?: JsxEvent.Focus.t => unit,
    onFocus?: JsxEvent.Focus.t => unit,
    onMouseEnter?: JsxEvent.Mouse.t => unit,
    onMouseLeave?: JsxEvent.Mouse.t => unit,
    @as("aria-label") ariaLabel?: string,
    @as("aria-labelledby") ariaLabelledby?: string,
    @as("aria-describedby") ariaDescribedby?: string,
    @as("aria-details") ariaDetails?: string,
    @as("aria-hidden") ariaHidden?: bool,
    @as("aria-roledescription") ariaRoledescription?: string,
    @as("aria-disabled") ariaDisabled?: bool,
    @as("aria-expanded") ariaExpanded?: bool,
    @as("aria-controls") ariaControls?: string,
    @as("aria-haspopup")
    ariaHaspopup?: [#dialog | #grid | #listbox | #menu | #tree | #"false" | #"true"],
    @as("aria-invalid") ariaInvalid?: [#grammar | #"false" | #spelling | #"true"],
    @as("aria-pressed") ariaPressed?: [#"false" | #mixed | #"true"],
    @as("aria-current")
    ariaCurrent?: [#date | #location | #page | #step | #time | #"false" | #"true"],
    @as("data-slot") dataSlot?: string,
    @as("data-size") dataSize?: string,
    @as("data-variant") dataVariant?: string,
    @as("data-orientation") dataOrientation?: string,
    @as("data-spacing") dataSpacing?: float,
    @as("data-inset") dataInset?: bool,
    @as("data-icon") dataIcon?: string,
    @as("data-checked") dataChecked?: bool,
    @as("data-selected") dataSelected?: bool,
    @as("data-active") dataActive?: bool,
    @as("data-empty") dataEmpty?: bool,
    @as("data-disabled") dataDisabled?: bool,
    @as("data-invalid") dataInvalid?: bool,
    @as("data-unchecked") dataUnchecked?: bool,
    @as("data-align-trigger") dataAlignTrigger?: bool,
    @as("data-lang") dataLang?: string,
    @as("data-sidebar") dataSidebar?: string,
    @as("data-mobile") dataMobile?: string,
    @as("data-side") dataSide?: string,
    @as("data-day") dataDay?: string,
    @as("data-selected-single") dataSelectedSingle?: bool,
    @as("data-range-start") dataRangeStart?: bool,
    @as("data-range-end") dataRangeEnd?: bool,
    @as("data-range-middle") dataRangeMiddle?: bool,
    @as("data-state") dataState?: string,
    @as("cmdk-group-heading") cmdkGroupHeading?: string,
    @as("data-chips") dataChips?: bool,
    @as("onPress") onPress?: PressEvent.t => unit,
  }
}

module ElementProps = {
  type t = {
    ...BaseProps.t,
    children?: React.element,
  }
}

module ButtonProps = {
  type t = {
    ...ElementProps.t,
    @as("isPending") isPending?: bool,
  }
}

module InputProps = {
  type t = {
    ...ElementProps.t,
    name?: string,
    value?: string,
    defaultValue?: string,
    placeholder?: string,
    @as("type") type_?: string,
    maxLength?: int,
    rows?: int,
    step?: float,
    pattern?: string,
    spellCheck?: bool,
    disabled?: bool,
    required?: bool,
    readOnly?: bool,
    onChange?: string => unit,
  }
}
