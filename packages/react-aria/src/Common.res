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
type placement =
  | @as("top") Top
  | @as("bottom") Bottom
  | @as("left") Left
  | @as("right") Right
  | @as("top start") TopStart
  | @as("top end") TopEnd
  | @as("bottom start") BottomStart
  | @as("bottom end") BottomEnd
  | @as("left top") LeftTop
  | @as("left bottom") LeftBottom
  | @as("right top") RightTop
  | @as("right bottom") RightBottom

type pressEvent
type key = string
type selection
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
  selectionMode: selectionMode,
  selectionBehavior: string,
  allowsDragging?: bool,
  isDragging?: bool,
  isDropTarget?: bool,
}

external itemRenderChildren: (itemRenderProps => React.element) => React.element = "%identity"

type baseProps = {
  key?: string,
  children?: React.element,
  ref?: ReactDOM.domRef,
  className?: string,
  id?: string,
  style?: ReactDOM.Style.t,
  dir?: string,
  role?: string,
  slot?: string,
  tabIndex?: int,
  hidden?: bool,
  onClick?: JsxEvent.Mouse.t => unit,
  onKeyDown?: JsxEvent.Keyboard.t => unit,
  @as("aria-label") ariaLabel?: string,
  @as("aria-invalid") ariaInvalid?: [#grammar | #"false" | #spelling | #"true"],
  @as("data-slot") dataSlot?: string,
  @as("data-size") dataSize?: string,
  @as("data-variant") dataVariant?: string,
  @as("data-orientation") dataOrientation?: string,
  @as("data-spacing") dataSpacing?: float,
  @as("data-inset") dataInset?: bool,
  @as("data-checked") dataChecked?: bool,
  @as("data-unchecked") dataUnchecked?: bool,
  @as("data-align-trigger") dataAlignTrigger?: bool,
  @as("data-lang") dataLang?: string,
  @as("data-sidebar") dataSidebar?: string,
  @as("data-mobile") dataMobile?: string,
  @as("data-side") dataSide?: string,
  @as("data-chips") dataChips?: bool,
  @as("onPress") onPress?: pressEvent => unit,
}

type buttonProps = {
  ...baseProps,
  @as("isPending") isPending?: bool,
}

type inputProps = {
  ...baseProps,
  name?: string,
  value?: string,
  defaultValue?: string,
  placeholder?: string,
  @as("type") type_?: string,
  maxLength?: int,
  step?: float,
  pattern?: string,
  spellCheck?: bool,
  disabled?: bool,
  required?: bool,
  readOnly?: bool,
  @as("aria-roledescription") ariaRoledescription?: string,
  onChange?: string => unit,
}

external pressEventToMouseEvent: pressEvent => JsxEvent.Mouse.t = "%identity"
