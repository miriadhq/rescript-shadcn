type props = {
  ...Common.baseProps,
  selectedKey?: string,
  defaultSelectedKey?: string,
  onSelectionChange?: string => unit,
  orientation?: Types.Orientation.t,
  isDisabled?: bool,
  keyboardActivation?: [#automatic | #manual],
}

@module("react-aria-components")
external make: React.component<props> = "Tabs"

module List = {
  @module("react-aria-components")
  external make: React.component<Common.baseProps> = "TabList"
}

module Tab = {
  type props = {
    ...Common.baseProps,
    isDisabled?: bool,
  }

  @module("react-aria-components")
  external make: React.component<props> = "Tab"
}

module Panels = {
  @module("react-aria-components")
  external make: React.component<Common.baseProps> = "TabPanels"
}

module Panel = {
  type props = Common.baseProps

  @module("react-aria-components")
  external make: React.component<props> = "TabPanel"
}
