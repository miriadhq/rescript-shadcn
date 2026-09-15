@@directive("'use client'")

module Provider = {
  @react.componentWithProps(BaseUi.Types.BaseUIComponentProps.t)
  let make = (props: BaseUi.Types.BaseUIComponentProps.t) => <BaseUi.DirectionProvider {...props} />
}

let use = BaseUi.DirectionProvider.useDirection
