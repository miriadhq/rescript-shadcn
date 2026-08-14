/** Shared React Aria component types, grounded in react-aria-components 1.19.0. */

@unboxed
type orientation =
  | @as("horizontal") Horizontal
  | @as("vertical") Vertical

@unboxed
type selectionMode =
  | @as("single") Single
  | @as("multiple") Multiple

@unboxed
type itemSelectionMode =
  | @as("none") None
  | @as("single") Single
  | @as("multiple") Multiple

@unboxed
type selectionBehavior =
  | @as("toggle") Toggle
  | @as("replace") Replace

@unboxed
type disabledBehavior =
  | @as("all") All
  | @as("selection") Selection

@unboxed
type autoFocus =
  | Bool(bool)
  | @as("first") First
  | @as("last") Last

@unboxed
type escapeKeyBehavior =
  | @as("clearSelection") ClearSelection
  | @as("none") None

@unboxed
type placement =
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

type pressEvent
type key = string
@unboxed
type selection =
  | @as("all") All
  | Keys(Set.t<string>)
type dateValue

type renderState = {
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

/**
 * The state passed to the render-function form of collection item children.
 *
 * React Aria models `children` as a TypeScript union of a React node and a
 * callback. ReScript cannot express that union directly, so `itemRenderChildren`
 * performs the zero-cost, typed conversion for the callback form.
 */
type itemRenderProps = {
  defaultChildren?: React.element,
  isHovered: bool,
  isPressed: bool,
  isSelected: bool,
  isFocused: bool,
  isFocusVisible: bool,
  isDisabled: bool,
  selectionMode: itemSelectionMode,
  selectionBehavior: string,
  allowsDragging?: bool,
  isDragging?: bool,
  isDropTarget?: bool,
}

external itemRenderChildren: (itemRenderProps => React.element) => React.element = "%identity"
external itemRenderClassName: (itemRenderProps => string) => string = "%identity"

@module("react-aria-components")
external composeRenderProps: (
  option<'children>,
  (React.element, 'renderProps) => React.element,
) => 'renderProps => React.element = "composeRenderProps"

/**
 * `composeRenderProps` returns a function, which is also a valid React child at
 * runtime. This declaration keeps that zero-cost representation usable by
 * collection components whose bindings expose `children` as `React.element`.
 */
@module("react-aria-components")
external composeItemRenderProps: (
  option<React.element>,
  (React.element, itemRenderProps) => React.element,
) => React.element = "composeRenderProps"

type baseProps = {
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
  @as("aria-haspopup") ariaHaspopup?: [#dialog | #grid | #listbox | #menu | #tree | #"false" | #"true"],
  @as("aria-invalid") ariaInvalid?: [#grammar | #"false" | #spelling | #"true"],
  @as("aria-pressed") ariaPressed?: [#"false" | #mixed | #"true"],
  @as("aria-current") ariaCurrent?: [#date | #location | #page | #step | #time | #"false" | #"true"],
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
  @as("onPress") onPress?: pressEvent => unit,
}

type elementProps = {
  ...baseProps,
  children?: React.element,
}

type buttonProps = {
  ...elementProps,
  @as("isPending") isPending?: bool,
}

type inputProps = {
  ...elementProps,
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

external pressEventToMouseEvent: pressEvent => JsxEvent.Mouse.t = "%identity"
