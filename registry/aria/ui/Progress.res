@@directive("'use client'")

@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

@module("cn")
external cn: (string, option<string>) => string = "cn"

type contextValue = {
  percentage: option<float>,
  isIndeterminate: bool,
  valueText: option<string>,
}

let context: React.Context.t<option<contextValue>> = React.createContext(None)

module Context = {
  let make = React.Context.provider(context)
}

let use = () =>
  switch React.useContext(context) {
  | Some(value) => value
  | None => JsError.throwWithMessage("useProgress must be used within a Progress.")
  }

module Track = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) => {
    let dataSlot = props.dataSlot->Option.getOr("progress-track")
    <span
      {...props}
      dataSlot
      className={cn(
        "cn-progress-track relative flex w-full items-center overflow-x-hidden",
        props.className,
      )}
    />
  }
}

module Indicator = {
  @react.componentWithProps(ReactAria.Types.DomProps.t)
  let make = (props: ReactAria.Types.DomProps.t) => {
    let dataSlot = props.dataSlot->Option.getOr("progress-indicator")
    let {percentage, isIndeterminate} = use()
    let percentage = isIndeterminate ? 100. : percentage->Option.getOr(0.)
    let width = percentage->Float.toString ++ "%"
    let style = switch props.style {
    | Some(style) => style->ReactDOM.Style.unsafeAddProp("width", width)
    | None => ReactDOM.Style._dictToStyle(dict{"width": width})
    }
    <span
      {...props}
      style
      dataSlot
      className={cn("cn-progress-indicator h-full transition-all", props.className)}
    />
  }
}

type props = {children?: React.element, ...ReactAria.ProgressBar.componentProps}

let progressProps: props => ReactAria.ProgressBar.componentProps = %raw(`({children, ...props}) => props`)

@react.componentWithProps(props)
let make = (props: props) => {
  let dataSlot = props.dataSlot->Option.getOr("progress")
  <ReactAria.ProgressBar
    {...props->progressProps->ReactAria.ProgressBar.toProps}
    dataSlot
    className={cn("cn-progress-root flex flex-wrap gap-3", props.className)}
  >
    {({percentage, valueText, isIndeterminate}) =>
      <Context
        value={Some({
          percentage: percentage->Nullable.toOption,
          valueText: valueText->Nullable.toOption,
          isIndeterminate,
        })}
      >
        {props.children->Option.getOr(React.null)}
        <Track>
          <Indicator />
        </Track>
      </Context>}
  </ReactAria.ProgressBar>
}
module Label = {
  @react.componentWithProps(ReactAria.Label.props)
  let make = (props: ReactAria.Label.props) => {
    let dataSlot = props.dataSlot->Option.getOr("progress-label")
    <ReactAria.Label {...props} dataSlot className={cn("cn-progress-label", props.className)} />
  }
}

module Value = {
  type props = {children?: string => React.element, ...ReactAria.Common.baseProps}
  let spanProps: props => ReactAria.Types.DomProps.t = %raw(`({children, ...props}) => props`)

  @react.componentWithProps(props)
  let make = (props: props) => {
    let dataSlot = props.dataSlot->Option.getOr("progress-value")
    let {valueText} = use()
    let content = switch (props.children, valueText) {
    | (Some(render), Some(value)) => render(value)
    | (_, Some(value)) => value->React.string
    | _ => React.null
    }
    <span {...props->spanProps} dataSlot className={cn("cn-progress-value", props.className)}>
      {content}
    </span>
  }
}
