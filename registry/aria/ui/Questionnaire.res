@@directive("'use client'")
@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

@module("cn") external cn: (string, option<string>) => string = "cn"
@module("cn") external cn3: (string, string, option<string>) => string = "cn"

module Primitive = ShadcnReact.Questionnaire
module Shortcuts = {
  type t = Primitive.shortcuts
}
module Status = {
  type t = Primitive.status
}

type props = Primitive.Root.props
let toPrimitiveProps: props => props = %raw(`({className, ...props}) => props`)
@react.componentWithProps(props)
let make = (props: props) =>
  <Primitive.Root
    {...toPrimitiveProps(props)}
    dataSlot={props.dataSlot->Option.getOr("questionnaire")}
    className={cn("cn-questionnaire flex w-full min-w-0 flex-col", props.className)}
  />

module Progress = {
  type props = Primitive.Progress.props
  let toPrimitiveProps: props => props = %raw(`({className, ...props}) => props`)
  @react.componentWithProps(props)
  let make = (props: props) =>
    <Primitive.Progress
      {...toPrimitiveProps(props)}
      dataSlot={props.dataSlot->Option.getOr("questionnaire-progress")}
      className={cn(
        "cn-questionnaire-progress min-h-[1lh] w-fit min-w-[14ch] font-medium text-muted-foreground tabular-nums",
        props.className,
      )}
    />
  module WithRender = {
    type props = Primitive.Progress.WithRender.props
    let toPrimitiveProps: props => props = %raw(`({className, ...props}) => props`)
    @react.componentWithProps(props)
    let make = (props: props) =>
      <Primitive.Progress.WithRender
        {...toPrimitiveProps(props)}
        dataSlot={props.dataSlot->Option.getOr("questionnaire-progress")}
        className={cn(
          "cn-questionnaire-progress min-h-[1lh] w-fit min-w-[14ch] font-medium text-muted-foreground tabular-nums",
          props.className,
        )}
      />
  }
}

module Item = {
  type props = Primitive.Item.props
  let toPrimitiveProps: props => props = %raw(`({className, ...props}) => props`)
  @react.componentWithProps(props)
  let make = (props: props) =>
    <Primitive.Item
      {...toPrimitiveProps(props)}
      dataSlot={props.dataSlot->Option.getOr("questionnaire-item")}
      className={cn("cn-questionnaire-item min-w-0 border-0 p-0 outline-none", props.className)}
    />
}

module Title = {
  type props = Primitive.Title.props
  let toPrimitiveProps: props => props = %raw(`({className, ...props}) => props`)
  @react.componentWithProps(props)
  let make = (props: props) =>
    <Primitive.Title
      {...toPrimitiveProps(props)}
      dataSlot={props.dataSlot->Option.getOr("questionnaire-title")}
      className={cn("cn-questionnaire-title cn-font-heading text-pretty", props.className)}
    />
}

module Description = {
  type props = Primitive.Description.props
  let toPrimitiveProps: props => props = %raw(`({className, ...props}) => props`)
  @react.componentWithProps(props)
  let make = (props: props) =>
    <Primitive.Description
      {...toPrimitiveProps(props)}
      dataSlot={props.dataSlot->Option.getOr("questionnaire-description")}
      className={cn(
        "cn-questionnaire-description text-pretty text-muted-foreground",
        props.className,
      )}
    />
}

module Choices = {
  type props = Primitive.Choices.props
  let toPrimitiveProps: props => props = %raw(`({className, ...props}) => props`)
  @react.componentWithProps(props)
  let make = (props: props) =>
    <Primitive.Choices
      {...toPrimitiveProps(props)}
      dataSlot={props.dataSlot->Option.getOr("questionnaire-choices")}
      className={cn(
        "cn-questionnaire-choices group/questionnaire-choices grid min-w-0",
        props.className,
      )}
    />
}

module Error = {
  type props = Primitive.Error.props
  let toPrimitiveProps: props => props = %raw(`({className, ...props}) => props`)
  @react.componentWithProps(props)
  let make = (props: props) =>
    <Primitive.Error
      {...toPrimitiveProps(props)}
      dataSlot={props.dataSlot->Option.getOr("questionnaire-error")}
      className={cn("cn-questionnaire-error text-destructive", props.className)}
    />
}

module ChoiceDescription = {
  type props = ReactAria.Types.DomProps.t
  let toDomProps: props => props = %raw(`({className, ...props}) => props`)
  @react.componentWithProps(props)
  let make = (props: props) =>
    <span
      {...toDomProps(props)}
      dataSlot={props.dataSlot->Option.getOr("questionnaire-choice-description")}
      className={cn("cn-questionnaire-choice-description", props.className)}
    />
}

module Actions = {
  type props = ReactAria.Types.DomProps.t
  let toDomProps: props => props = %raw(`({className, ...props}) => props`)
  @react.componentWithProps(props)
  let make = (props: props) =>
    <div
      {...toDomProps(props)}
      dataSlot={props.dataSlot->Option.getOr("questionnaire-actions")}
      className={cn(
        "cn-questionnaire-actions grid min-h-11 w-full grid-cols-[minmax(0,1fr)_auto_auto] items-center",
        props.className,
      )}
    />
}

module Choice = {
  type props = Primitive.Choice.props
  let toPrimitiveProps: props => props = %raw(`({className, children, ...props}) => props`)
  @react.componentWithProps(props)
  let make = (props: props) =>
    <Primitive.Choice
      {...toPrimitiveProps(props)}
      dataSlot={props.dataSlot->Option.getOr("questionnaire-choice")}
      className={cn(
        "cn-questionnaire-choice group/questionnaire-choice relative flex min-h-11 cursor-pointer items-start text-start transition-colors outline-none select-none data-disabled:pointer-events-none data-disabled:cursor-not-allowed data-disabled:opacity-50",
        props.className,
      )}
    >
      <Primitive.ChoiceInput
        dataSlot="questionnaire-choice-input"
        className="cn-questionnaire-choice-input absolute inset-0 z-10 size-full cursor-pointer opacity-0"
      />
      <span
        ariaHidden=true
        dataSlot="questionnaire-choice-indicator"
        className="cn-questionnaire-choice-indicator pointer-events-none relative flex shrink-0 items-center justify-center border group-data-[type=radio]/questionnaire-choice:rounded-full"
      >
        <span
          dataSlot="questionnaire-choice-indicator-dot"
          className="cn-questionnaire-choice-indicator-dot hidden rounded-full group-data-[type=checkbox]/questionnaire-choice:hidden group-data-checked/questionnaire-choice:block"
        />
        <Icons.Check
          dataSlot="questionnaire-choice-indicator-check"
          className="cn-questionnaire-choice-indicator-check hidden group-data-[type=radio]/questionnaire-choice:hidden group-data-checked/questionnaire-choice:block"
        />
      </span>
      <Primitive.ChoiceLabel
        dataSlot="questionnaire-choice-label"
        className="cn-questionnaire-choice-label cn-questionnaire-choice-content flex min-w-0 flex-1 flex-col leading-snug"
      >
        {props.children->Option.getOr(React.null)}
      </Primitive.ChoiceLabel>
      <Primitive.ChoiceShortcut
        dataSlot="questionnaire-choice-shortcut"
        className="cn-questionnaire-choice-shortcut cn-questionnaire-shortcut pointer-events-none ms-auto hidden shrink-0 group-data-[shortcut]/questionnaire-choice:inline-flex"
      />
    </Primitive.Choice>
}

module Input = {
  type props = Primitive.Input.props
  let toPrimitiveProps: props => props = %raw(`({className, ...props}) => props`)
  @react.componentWithProps(props)
  let make = (props: props) =>
    <div
      dataSlot="questionnaire-input-wrapper"
      className="cn-questionnaire-input-wrapper group/questionnaire-input relative min-w-0"
    >
      <Primitive.Input
        {...toPrimitiveProps(props)}
        dataSlot={props.dataSlot->Option.getOr("questionnaire-input")}
        className={cn(
          "cn-questionnaire-input min-h-11 w-full min-w-0 transition-[color,box-shadow,background-color] outline-none disabled:pointer-events-none disabled:cursor-not-allowed disabled:opacity-50 sm:min-h-0 selection:bg-primary selection:text-primary-foreground placeholder:text-muted-foreground",
          props.className,
        )}
      />
    </div>
}

module Previous = {
  type props = {...Primitive.Previous.props, size?: Button.Size.t, variant?: Button.Variant.t}
  let toPrimitiveProps: props => Primitive.Previous.props = %raw(`({className, children, size, variant, ...props}) => props`)
  @react.componentWithProps(props)
  let make = (props: props) => {
    let size = props.size->Option.getOr(Button.Size.Default)
    let variant = props.variant->Option.getOr(Button.Variant.Outline)
    <Primitive.Previous
      {...toPrimitiveProps(props)}
      dataSlot={props.dataSlot->Option.getOr("questionnaire-previous")}
      dataSize={props.dataSize->Option.getOr((size :> string))}
      dataVariant={props.dataVariant->Option.getOr((variant :> string))}
      className={cn3(
        Button.buttonVariants(~size, ~variant),
        "cn-questionnaire-previous col-start-1 row-start-1 min-h-11 justify-self-start sm:min-h-0",
        props.className,
      )}
    >
      {props.children->Option.getOr(React.string("Previous"))}
    </Primitive.Previous>
  }
}

module Skip = {
  type props = {...Primitive.Skip.props, size?: Button.Size.t, variant?: Button.Variant.t}
  let toPrimitiveProps: props => Primitive.Skip.props = %raw(`({className, children, size, variant, ...props}) => props`)
  @react.componentWithProps(props)
  let make = (props: props) => {
    let size = props.size->Option.getOr(Button.Size.Default)
    let variant = props.variant->Option.getOr(Button.Variant.Outline)
    <Primitive.Skip
      {...toPrimitiveProps(props)}
      dataSlot={props.dataSlot->Option.getOr("questionnaire-skip")}
      dataSize={props.dataSize->Option.getOr((size :> string))}
      dataVariant={props.dataVariant->Option.getOr((variant :> string))}
      className={cn3(
        Button.buttonVariants(~size, ~variant),
        "cn-questionnaire-skip col-start-2 row-start-1 min-h-11 justify-self-end sm:min-h-0",
        props.className,
      )}
    >
      {props.children->Option.getOr(React.string("Skip"))}
    </Primitive.Skip>
  }
}

module Next = {
  type props = {...Primitive.Next.props, size?: Button.Size.t, variant?: Button.Variant.t}
  let toPrimitiveProps: props => Primitive.Next.props = %raw(`({className, children, size, variant, ...props}) => props`)
  @react.componentWithProps(props)
  let make = (props: props) => {
    let size = props.size->Option.getOr(Button.Size.Default)
    let variant = props.variant->Option.getOr(Button.Variant.Default)
    <Primitive.Next
      {...toPrimitiveProps(props)}
      dataSlot={props.dataSlot->Option.getOr("questionnaire-next")}
      dataSize={props.dataSize->Option.getOr((size :> string))}
      dataVariant={props.dataVariant->Option.getOr((variant :> string))}
      className={cn3(
        Button.buttonVariants(~size, ~variant),
        "cn-questionnaire-next col-start-3 row-start-1 min-h-11 justify-self-end sm:min-h-0",
        props.className,
      )}
    >
      {props.children->Option.getOr(React.string("Next"))}
    </Primitive.Next>
  }
}

module Submit = {
  type props = {...Primitive.Submit.props, size?: Button.Size.t, variant?: Button.Variant.t}
  let toPrimitiveProps: props => Primitive.Submit.props = %raw(`({className, children, size, variant, ...props}) => props`)
  @react.componentWithProps(props)
  let make = (props: props) => {
    let size = props.size->Option.getOr(Button.Size.Default)
    let variant = props.variant->Option.getOr(Button.Variant.Default)
    <Primitive.Submit
      {...toPrimitiveProps(props)}
      dataSlot={props.dataSlot->Option.getOr("questionnaire-submit")}
      dataSize={props.dataSize->Option.getOr((size :> string))}
      dataVariant={props.dataVariant->Option.getOr((variant :> string))}
      className={cn3(
        Button.buttonVariants(~size, ~variant),
        "cn-questionnaire-submit col-start-3 row-start-1 min-h-11 justify-self-end sm:min-h-0",
        props.className,
      )}
    >
      {props.children->Option.getOr(React.string("Submit"))}
    </Primitive.Submit>
  }
}
