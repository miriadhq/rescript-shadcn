@@directive("'use client'")

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

type props = {...BaseUi.RadioGroup.props<string>}

@warning("-112") @react.componentWithProps(props)
let make = ({?className, ...BaseUi.RadioGroup.props<string> as props}) =>
  <BaseUi.RadioGroup
    {...props} dataSlot="radio-group" className={cn("cn-radio-group w-full", className)}
  />

module Item = {
  type props = {...BaseUi.Radio.Root.props<string>}

  @warning("-112") @react.componentWithProps(props)
  let make = ({?className, ?children, ...BaseUi.Radio.Root.props<string> as props}) =>
    <BaseUi.Radio.Root
      {...props}
      dataSlot="radio-group-item"
      className={cn(
        "cn-radio-group-item group/radio-group-item peer relative aspect-square shrink-0 border outline-none after:absolute after:-inset-x-3 after:-inset-y-2 disabled:cursor-not-allowed disabled:opacity-50",
        className,
      )}
    >
      <BaseUi.Radio.Indicator dataSlot="radio-group-indicator" className="cn-radio-group-indicator">
        <span className="cn-radio-group-indicator-icon" />
      </BaseUi.Radio.Indicator>
      {children->Option.getOr(React.null)}
    </BaseUi.Radio.Root>
}
