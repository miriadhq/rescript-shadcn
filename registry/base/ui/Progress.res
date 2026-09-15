@@directive("'use client'")

@module("cn")
external cn: (string, option<string>) => string = "cn"

@react.componentWithProps(BaseUi.Progress.Root.props)
let make = (props: BaseUi.Progress.Root.props) => {
  let children = props.children->Option.getOr(React.null)
  <BaseUi.Progress.Root
    {...props}
    dataSlot={props.dataSlot->Option.getOr("progress")}
    className={cn("cn-progress-root flex flex-wrap gap-3", props.className)}
  >
    {children}
    <BaseUi.Progress.Track
      dataSlot="progress-track"
      className="cn-progress-track relative flex w-full items-center overflow-x-hidden"
    >
      <BaseUi.Progress.Indicator
        dataSlot="progress-indicator" className="cn-progress-indicator h-full transition-all"
      />
    </BaseUi.Progress.Track>
  </BaseUi.Progress.Root>
}

module Track = {
  @react.componentWithProps(BaseUi.Types.BaseUIComponentProps.t)
  let make = (props: BaseUi.Types.BaseUIComponentProps.t) =>
    <BaseUi.Progress.Track
      {...props}
      dataSlot={props.dataSlot->Option.getOr("progress-track")}
      className={cn(
        "cn-progress-track relative flex w-full items-center overflow-x-hidden",
        props.className,
      )}
    />
}

module Indicator = {
  @react.componentWithProps(BaseUi.Types.BaseUIComponentProps.t)
  let make = (props: BaseUi.Types.BaseUIComponentProps.t) =>
    <BaseUi.Progress.Indicator
      {...props}
      dataSlot={props.dataSlot->Option.getOr("progress-indicator")}
      className={cn("cn-progress-indicator h-full transition-all", props.className)}
    />
}

module Label = {
  @react.componentWithProps(BaseUi.Types.BaseUIComponentProps.t)
  let make = (props: BaseUi.Types.BaseUIComponentProps.t) =>
    <BaseUi.Progress.Label
      {...props}
      dataSlot={props.dataSlot->Option.getOr("progress-label")}
      className={cn("cn-progress-label", props.className)}
    />
}

module Value = {
  @react.componentWithProps(BaseUi.Types.BaseUIComponentProps.t)
  let make = (props: BaseUi.Types.BaseUIComponentProps.t) =>
    <BaseUi.Progress.Value
      {...props}
      dataSlot={props.dataSlot->Option.getOr("progress-value")}
      className={cn("cn-progress-value", props.className)}
    />
}
