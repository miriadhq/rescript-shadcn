@@directive("'use client'")

@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

type props = {...ReactAria.Checkbox.props}

@react.componentWithProps(props) @warning("-112")
let make = ({?children, ...ReactAria.Checkbox.props as props}) =>
  <ReactAria.Checkbox
    {...props}
    dataSlot="checkbox"
    className={cn(
      "cn-checkbox cn-checkbox-aria peer relative shrink-0 outline-none after:absolute after:-inset-x-3 after:-inset-y-2 data-[disabled]:cursor-not-allowed data-[disabled]:opacity-50",
      props.className,
    )}
    children={ReactAria.Common.composeRenderElement(children, (
      children,
      state: ReactAria.Checkbox.RenderProps.t,
    ) =>
      <>
        <span
          dataSlot="checkbox-indicator"
          className="cn-checkbox-indicator grid place-content-center text-current transition-none"
        >
          {state.isSelected || state.isIndeterminate ? <Icons.Check /> : React.null}
        </span>
        {children}
      </>
    )}
  />
