type props = {
  ...Common.ElementProps.t,
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
  type props<'item> = {...Common.ElementProps.t, items?: array<'item>}
  @module("react-aria-components")
  external make: React.component<props<'item>> = "TabList"
}

module Tab = {
  type props = {
    ...Common.ElementProps.t,
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
  external make: React.component<Common.ElementProps.t> = "TabPanels"
}

module Panel = {
  type props = {...Common.ElementProps.t, shouldForceMount?: bool}

  @module("react-aria-components")
  external make: React.component<props> = "TabPanel"
}
