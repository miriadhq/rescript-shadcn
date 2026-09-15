@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

@module("cn")
external cn: (string, option<string>) => string = "cn"

module State = {
  @unboxed
  type t =
    | @as("idle") Idle
    | @as("uploading") Uploading
    | @as("processing") Processing
    | @as("error") Error
    | @as("done") Done
}

module Size = {
  @unboxed
  type t =
    | @as("default") Default
    | @as("sm") Sm
    | @as("xs") Xs
}

module Orientation = {
  @unboxed
  type t =
    | @as("horizontal") Horizontal
    | @as("vertical") Vertical
}

module MediaVariant = {
  @unboxed
  type t =
    | @as("icon") Icon
    | @as("image") Image
}

let sizeClass = (~size: Size.t) =>
  switch size {
  | Default => "cn-attachment-size-default"
  | Sm => "cn-attachment-size-sm"
  | Xs => "cn-attachment-size-xs"
  }

let orientationClass = (~orientation: Orientation.t) =>
  switch orientation {
  | Horizontal => "cn-attachment-orientation-horizontal items-center"
  | Vertical => "cn-attachment-orientation-vertical flex-col"
  }

type props = {
  ...BaseUi.Types.BaseDomWithoutOrientationProps.t,
  ...BaseUi.Types.ExtraDomProps.t,
  children?: React.element,
  state?: State.t,
  size?: Size.t,
  orientation?: Orientation.t,
}

let toBaseUiProps: props => BaseUi.Types.DomProps.t = %raw(`({state, size, orientation, ...props}) => props`)

@react.componentWithProps(props)
let make = (props: props) => {
  let state = props.state->Option.getOr(State.Done)
  let size = props.size->Option.getOr(Size.Default)
  let orientation = props.orientation->Option.getOr(Orientation.Horizontal)
  <div
    {...props->toBaseUiProps}
    dataSlot={props.dataSlot->Option.getOr("attachment")}
    dataState={props.dataState->Option.getOr((state :> string))}
    dataSize={props.dataSize->Option.getOr((size :> string))}
    dataOrientation={props.dataOrientation->Option.getOr((orientation :> string))}
    className={cn(
      `cn-attachment group/attachment relative flex max-w-full min-w-0 shrink-0 flex-wrap border bg-card text-card-foreground transition-colors has-[>a,>button]:hover:bg-muted/50 data-[state=error]:border-destructive/30 data-[state=idle]:border-dashed ${sizeClass(
          ~size,
        )} ${orientationClass(~orientation)}`,
      props.className,
    )}
  />
}

module Media = {
  let variantClass = (~variant: MediaVariant.t) =>
    switch variant {
    | Icon => "cn-attachment-media-variant-icon"
    | Image => "cn-attachment-media-variant-image *:[img]:aspect-square *:[img]:w-full *:[img]:object-cover"
    }

  type props = {
    ...BaseUi.Types.DomProps.t,
    variant?: MediaVariant.t,
  }

  let toBaseUiProps: props => BaseUi.Types.DomProps.t = %raw(`({variant, ...props}) => props`)

  @react.componentWithProps(props)
  let make = (props: props) => {
    let variant = props.variant->Option.getOr(MediaVariant.Icon)
    <div
      {...props->toBaseUiProps}
      dataSlot={props.dataSlot->Option.getOr("attachment-media")}
      dataVariant={props.dataVariant->Option.getOr((variant :> string))}
      className={cn(
        `cn-attachment-media relative flex aspect-square shrink-0 items-center justify-center overflow-hidden group-data-[state=error]/attachment:bg-destructive/10 group-data-[state=error]/attachment:text-destructive [&_svg]:pointer-events-none ${variantClass(
            ~variant,
          )}`,
        props.className,
      )}
    />
  }
}

module Content = {
  @react.componentWithProps(BaseUi.Types.DomProps.t)
  let make = (props: BaseUi.Types.DomProps.t) =>
    <div
      {...props}
      dataSlot={props.dataSlot->Option.getOr("attachment-content")}
      className={cn("cn-attachment-content max-w-full min-w-0 flex-1", props.className)}
    />
}

module Title = {
  @react.componentWithProps(BaseUi.Types.DomProps.t)
  let make = (props: BaseUi.Types.DomProps.t) =>
    <span
      {...props}
      dataSlot={props.dataSlot->Option.getOr("attachment-title")}
      className={cn(
        "cn-attachment-title block max-w-full min-w-0 truncate group-data-[state=processing]/attachment:shimmer group-data-[state=uploading]/attachment:shimmer",
        props.className,
      )}
    />
}

module Description = {
  @react.componentWithProps(BaseUi.Types.DomProps.t)
  let make = (props: BaseUi.Types.DomProps.t) =>
    <span
      {...props}
      dataSlot={props.dataSlot->Option.getOr("attachment-description")}
      className={cn(
        "cn-attachment-description block max-w-full min-w-0 truncate text-muted-foreground group-data-[state=error]/attachment:text-destructive/80",
        props.className,
      )}
    />
}

module Actions = {
  @react.componentWithProps(BaseUi.Types.DomProps.t)
  let make = (props: BaseUi.Types.DomProps.t) =>
    <div
      {...props}
      dataSlot={props.dataSlot->Option.getOr("attachment-actions")}
      className={cn("cn-attachment-actions flex shrink-0 items-center", props.className)}
    />
}

module Action = {
  @react.componentWithProps(Button.props)
  let make = (props: Button.props) =>
    <Button
      {...props}
      dataSlot={props.dataSlot->Option.getOr("attachment-action")}
      variant={props.variant->Option.getOr(Ghost)}
      size={props.size->Option.getOr(IconXs)}
      className={cn("cn-attachment-action", props.className)}
    />
}

module Trigger = {
  type props = {
    ...BaseUi.Types.BaseUIComponentWithoutTypeProps.t,
    @as("type") type_?: BaseUi.Types.ButtonType.t,
  }
  type state = {slot: string}
  let toDomProps: props => BaseUi.Types.DomProps.t = %raw(`({className, render, type, ...props}) => props`)
  @react.componentWithProps(props)
  let make = (props: props) => {
    let type_ = switch props.render {
    | Some(_) => props.type_
    | None => Some(props.type_->Option.getOr(Button))
    }
    BaseUi.Render.use({
      defaultTagName: "button",
      props: BaseUi.Render.mergeProps(
        {
          type_: ?(type_->Option.map(value => (value :> string))),
          className: cn(
            "cn-attachment-trigger absolute inset-0 z-10 outline-none",
            props.className,
          ),
        },
        toDomProps(props),
      ),
      render: ?props.render,
      state: {slot: "attachment-trigger"},
    })
  }
}

module Group = {
  @react.componentWithProps(BaseUi.Types.DomProps.t)
  let make = (props: BaseUi.Types.DomProps.t) =>
    <div
      {...props}
      dataSlot={props.dataSlot->Option.getOr("attachment-group")}
      className={cn(
        "cn-attachment-group flex min-w-0 scroll-fade-x snap-x snap-mandatory scrollbar-none overflow-x-auto overscroll-x-contain *:data-[slot=attachment]:flex-none *:data-[slot=attachment]:snap-start",
        props.className,
      )}
    />
}
