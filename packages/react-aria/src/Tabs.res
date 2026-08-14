type props = {
  ...Common.elementProps,
  selectedKey?: string,
  defaultSelectedKey?: string,
  onSelectionChange?: string => unit,
  orientation?: Types.Orientation.t,
  isDisabled?: bool,
  keyboardActivation?: [#automatic | #manual],
  disabledKeys?: array<string>,
}

@module("react-aria-components")
external make: React.component<props> = "Tabs"

module List = {
  type props<'item> = {...Common.elementProps, items?: array<'item>}
  @module("react-aria-components")
  external make: React.component<props<'item>> = "TabList"
}

module Tab = {
  type props = {
    ...Common.elementProps,
    isDisabled?: bool,
    href?: string,
    target?: string,
    rel?: string,
    download?: string,
  }

  @module("react-aria-components")
  external make: React.component<props> = "Tab"
}

module Panels = {
  @module("react-aria-components")
  external make: React.component<Common.elementProps> = "TabPanels"
}

module Panel = {
  type props = {...Common.elementProps, shouldForceMount?: bool}

  @module("react-aria-components")
  external make: React.component<props> = "TabPanel"
}
