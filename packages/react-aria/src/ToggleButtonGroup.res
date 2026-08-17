module ComponentProps = {
  type t = {
    ...Common.BaseProps.t,
    selectedKeys?: array<string>,
    defaultSelectedKeys?: array<string>,
    onSelectionChange?: Set.t<string> => unit,
    isDisabled?: bool,
    selectionMode?: Common.SelectionMode.t,
    disallowEmptySelection?: bool,
    orientation?: Common.Orientation.t,
  }
}

type props = {...ComponentProps.t, children?: React.element}

@module("react-aria-components")
external make: React.component<props> = "ToggleButtonGroup"
