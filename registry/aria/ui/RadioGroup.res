@@directive("'use client'")

@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

@react.componentWithProps(props)
let make = (props: ReactAria.RadioGroup.props) =>
  <ReactAria.RadioGroup
    {...props}
    dataSlot="radio-group"
    className={cn("cn-radio-group w-full", props.className)}
  />

module Item = {
  type props<'children> = {children?: 'children, ...ReactAria.Radio.componentProps}

  let radioProps: props<'children> => ReactAria.Radio.componentProps = %raw(`({children, ...props}) => props`)

  @react.componentWithProps(props)
  let make = (props: props<'children>) =>
    <ReactAria.Radio
      {...props->radioProps->ReactAria.Radio.toProps}
      dataSlot="radio-group-item"
      className={cn(
        "cn-radio-group-item cn-radio-group-item-aria group/radio-group-item peer relative aspect-square shrink-0 border outline-none after:absolute after:-inset-x-3 after:-inset-y-2 data-[disabled]:cursor-not-allowed data-[disabled]:opacity-50",
        props.className,
      )}
    >
      {ReactAria.Common.composeRenderProps(props.children, (children, state: ReactAria.Radio.renderProps) =>
        <>
          <span dataSlot="radio-group-indicator" className="cn-radio-group-indicator">
            {state.isSelected ? <span className="cn-radio-group-indicator-icon" /> : React.null}
          </span>
          {children}
        </>
      )}
    </ReactAria.Radio>
}
