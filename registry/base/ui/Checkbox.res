@@directive("'use client'")

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

type props = BaseUi.Checkbox.Root.props

let toBaseUiProps: props => BaseUi.Checkbox.Root.props = %raw(`({className, ...props}) => props`)

@react.componentWithProps(props)
let make = (props: props) => {
  <BaseUi.Checkbox.Root
    {...toBaseUiProps(props)}
    dataSlot="checkbox"
    className={cn(
      "cn-checkbox peer relative shrink-0 outline-none after:absolute after:-inset-x-3 after:-inset-y-2 disabled:cursor-not-allowed disabled:opacity-50",
      props.className,
    )}
  >
    <BaseUi.Checkbox.Indicator
      dataSlot="checkbox-indicator"
      className="cn-checkbox-indicator grid place-content-center text-current transition-none"
    >
      <Icons.Check />
    </BaseUi.Checkbox.Indicator>
  </BaseUi.Checkbox.Root>
}
