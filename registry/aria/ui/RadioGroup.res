@@directive("'use client'")

@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

@react.componentWithProps(props)
let make = (props: ReactAria.RadioGroup.props) =>
  <ReactAria.RadioGroup
    {...props} dataSlot="radio-group" className={cn("cn-radio-group w-full", props.className)}
  />

module Item = {
  type props = {...ReactAria.Radio.props}

  @react.componentWithProps(props) @warning("-112")
  let make = ({?children, ...ReactAria.Radio.props as props}) =>
    <ReactAria.Radio
      {...props}
      dataSlot="radio-group-item"
      className={cn(
        "cn-radio-group-item cn-radio-group-item-aria group/radio-group-item peer relative aspect-square shrink-0 border outline-none after:absolute after:-inset-x-3 after:-inset-y-2 data-[disabled]:cursor-not-allowed data-[disabled]:opacity-50",
        props.className,
      )}
      children={ReactAria.Common.composeRenderElement(children, (
        children,
        state: ReactAria.Radio.RenderProps.t,
      ) =>
        <>
          <span dataSlot="radio-group-indicator" className="cn-radio-group-indicator">
            {state.isSelected ? <span className="cn-radio-group-indicator-icon" /> : React.null}
          </span>
          {children}
        </>
      )}
    />
}
