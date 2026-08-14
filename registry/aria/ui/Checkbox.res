@@directive("'use client'")

@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

type props<'children> = {children?: 'children, ...ReactAria.Checkbox.componentProps}

let checkboxProps: props<'children> => ReactAria.Checkbox.componentProps = %raw(`({children, ...props}) => props`)

@react.componentWithProps(props)
let make = (props: props<'children>) =>
  <ReactAria.Checkbox
    {...props->checkboxProps->ReactAria.Checkbox.toProps}
    dataSlot="checkbox"
    className={cn(
      "cn-checkbox cn-checkbox-aria peer relative shrink-0 outline-none after:absolute after:-inset-x-3 after:-inset-y-2 data-[disabled]:cursor-not-allowed data-[disabled]:opacity-50",
      props.className,
    )}
  >
    {ReactAria.Common.composeRenderProps(
      props.children,
      (children, state: ReactAria.Checkbox.renderProps) =>
        <>
          <span
            dataSlot="checkbox-indicator"
            className="cn-checkbox-indicator grid place-content-center text-current transition-none"
          >
            {state.isSelected || state.isIndeterminate ? <Icons.Check /> : React.null}
          </span>
          {children}
        </>,
    )}
  </ReactAria.Checkbox>
