@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

module Direction = {
  @unboxed
  type t = ShadcnReact.MessageScroller.Direction.t =
    | @as("start") Start
    | @as("end") End
}

module DefaultScrollPosition = {
  @unboxed
  type t = ShadcnReact.MessageScroller.DefaultScrollPosition.t =
    | @as("start") Start
    | @as("end") End
    | @as("last-anchor") LastAnchor
}

module ScrollBehavior = {
  @unboxed
  type t = ShadcnReact.MessageScroller.ScrollBehavior.t =
    | @as("auto") Auto
    | @as("instant") Instant
    | @as("smooth") Smooth
}

module ScrollAlign = {
  @unboxed
  type t = ShadcnReact.MessageScroller.ScrollAlign.t =
    | @as("start") Start
    | @as("center") Center
    | @as("end") End
    | @as("nearest") Nearest
}

module UiButton = Button

let useMessageScroller = ShadcnReact.MessageScroller.useMessageScroller
let useMessageScrollerScrollable = ShadcnReact.MessageScroller.useMessageScrollerScrollable
let useMessageScrollerVisibility = ShadcnReact.MessageScroller.useMessageScrollerVisibility

module Provider = {
  @react.componentWithProps(ShadcnReact.MessageScroller.Provider.props)
  let make = (props: ShadcnReact.MessageScroller.Provider.props) =>
    <ShadcnReact.MessageScroller.Provider {...props} />
}

@react.componentWithProps(ShadcnReact.MessageScroller.Root.props)
let make = (props: ShadcnReact.MessageScroller.Root.props) =>
  <ShadcnReact.MessageScroller.Root
    {...props}
    dataSlot="message-scroller"
    className={cn(
      "cn-message-scroller group/message-scroller relative flex size-full min-h-0 flex-col overflow-hidden",
      props.className,
    )}
  />

module Viewport = {
  @react.componentWithProps(ShadcnReact.MessageScroller.Viewport.props)
  let make = (props: ShadcnReact.MessageScroller.Viewport.props) =>
    <ShadcnReact.MessageScroller.Viewport
      {...props}
      dataSlot="message-scroller-viewport"
      className={cn(
        "cn-message-scroller-viewport size-full min-h-0 min-w-0 scroll-fade-b scrollbar-thin scrollbar-gutter-stable overflow-y-auto overscroll-contain contain-content data-autoscrolling:scrollbar-thumb-transparent data-autoscrolling:scrollbar-track-transparent",
        props.className,
      )}
    />
}

module Content = {
  @react.componentWithProps(ShadcnReact.MessageScroller.Content.props)
  let make = (props: ShadcnReact.MessageScroller.Content.props) =>
    <ShadcnReact.MessageScroller.Content
      {...props}
      dataSlot="message-scroller-content"
      className={cn(
        "cn-message-scroller-content flex h-max min-h-full flex-col",
        props.className,
      )}
    />
}

module Item = {
  @react.componentWithProps(ShadcnReact.MessageScroller.Item.props)
  let make = (props: ShadcnReact.MessageScroller.Item.props) =>
    <ShadcnReact.MessageScroller.Item
      {...props}
      scrollAnchor={props.scrollAnchor->Option.getOr(false)}
      dataSlot="message-scroller-item"
      className={cn(
        "cn-message-scroller-item min-w-0 shrink-0 [contain-intrinsic-size:auto_10rem] [content-visibility:auto]",
        props.className,
      )}
    />
}

module Button = {
  type props = {
    variant?: UiButton.Variant.t,
    size?: UiButton.Size.t,
    ...ShadcnReact.MessageScroller.Button.props,
  }
  let primitiveProps: props => ShadcnReact.MessageScroller.Button.props = %raw(
    `({variant, size, ...props}) => props`
  )

  @react.componentWithProps(props)
  let make = (props: props) => {
    let direction = props.direction->Option.getOr(End)
    let variant = props.variant->Option.getOr(Secondary)
    let size = props.size->Option.getOr(IconSm)
    <ShadcnReact.MessageScroller.Button
      {...props->primitiveProps}
      render={props.render->Option.getOr(<UiButton variant size />)}
      dataDirection={props.dataDirection->Option.getOr(direction)}
      dataVariant={props.dataVariant->Option.getOr((variant :> string))}
      dataSize={props.dataSize->Option.getOr((size :> string))}
      direction
      type_={props.type_->Option.getOr("button")}
      dataSlot={props.dataSlot->Option.getOr("message-scroller-button")}
      className={cn(
        "cn-message-scroller-button absolute inset-s-1/2 -translate-x-1/2 border-border bg-background text-foreground transition-[translate,scale,opacity] duration-200 hover:bg-muted hover:text-foreground data-[active=false]:pointer-events-none data-[active=false]:scale-95 data-[active=false]:opacity-0 data-[active=false]:duration-400 data-[active=false]:ease-[cubic-bezier(0.7,0,0.84,0)] data-[active=true]:translate-y-0 data-[active=true]:scale-100 data-[active=true]:opacity-100 data-[active=true]:ease-[cubic-bezier(0.23,1,0.32,1)] data-[direction=end]:bottom-4 data-[direction=end]:data-[active=false]:translate-y-full data-[direction=start]:top-4 data-[direction=start]:data-[active=false]:-translate-y-full rtl:translate-x-1/2 data-[direction=start]:[&_svg]:rotate-180",
        props.className,
      )}
    >
      {props.children->Option.getOr(
        React.array([
          <Icons.ArrowDown key="icon" />,
          <span key="label" className="sr-only">
            {(
              switch direction {
              | End => "Scroll to end"
              | Start => "Scroll to start"
              }
            )->React.string}
          </span>,
        ]),
      )}
    </ShadcnReact.MessageScroller.Button>
  }
}
