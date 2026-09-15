@@directive("'use client'")

@module("cn")
external cn: (string, option<string>) => string = "cn"

@react.componentWithProps(BaseUi.RadioGroup.props)
let make = (props: BaseUi.RadioGroup.props<'value>) =>
  <BaseUi.RadioGroup
    {...props}
    dataSlot={props.dataSlot->Option.getOr("radio-group")}
    className={cn("cn-radio-group w-full", props.className)}
  />

module Item = {
  @react.componentWithProps(BaseUi.Radio.Root.props)
  let make = (props: BaseUi.Radio.Root.props<'value>) => {
    let children = props.children->Option.getOr(React.null)
    <BaseUi.Radio.Root
      {...props}
      dataSlot={props.dataSlot->Option.getOr("radio-group-item")}
      className={cn(
        "cn-radio-group-item group/radio-group-item peer relative aspect-square shrink-0 border outline-none after:absolute after:-inset-x-3 after:-inset-y-2 disabled:cursor-not-allowed disabled:opacity-50",
        props.className,
      )}
    >
      <BaseUi.Radio.Indicator dataSlot="radio-group-indicator" className="cn-radio-group-indicator">
        <span className="cn-radio-group-indicator-icon" />
      </BaseUi.Radio.Indicator>
      {children}
    </BaseUi.Radio.Root>
  }
}
