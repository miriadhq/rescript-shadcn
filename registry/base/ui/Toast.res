@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

@@directive("'use client'")

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

let createToastManager = BaseUi.Toast.createToastManager
let useToastManager = BaseUi.Toast.useToastManager
let toast = createToastManager()

module Provider = {
  let make = BaseUi.Toast.Provider.make
}

module Portal = {
  @react.componentWithProps(BaseUi.Types.BaseUIComponentProps.t)
  let make = (props: BaseUi.Types.BaseUIComponentProps.t) =>
    <BaseUi.Toast.Portal {...props} dataSlot="toast-portal" />
}

module Viewport = {
  @react.componentWithProps(BaseUi.Types.BaseUIComponentProps.t)
  let make = (props: BaseUi.Types.BaseUIComponentProps.t) =>
    <BaseUi.Toast.Viewport
      {...props}
      dataSlot="toast-viewport"
      className={cn(
        "pointer-events-none fixed inset-x-4 bottom-4 z-50 mx-auto w-auto max-w-sm outline-none sm:right-4 sm:left-auto sm:mx-0 sm:w-full",
        props.className,
      )}
    />
}

module Root = {
  @react.component
  let make = (~className=?, ~children=?, ~toast) =>
    <BaseUi.Toast.Root
      toast
      dataSlot="toast"
      className={cn(
        "cn-toast group/toast pointer-events-auto absolute right-0 bottom-0 z-[calc(1000-var(--toast-index))] w-full origin-bottom border bg-popover text-popover-foreground shadow-lg will-change-transform outline-none select-none focus-visible:border-ring focus-visible:ring-[3px] focus-visible:ring-ring/50 [--gap:0.75rem] [--height:var(--toast-frontmost-height,var(--toast-height))] [--offset-y:calc(var(--toast-offset-y)*-1+calc(var(--toast-index)*var(--gap)*-1)+var(--toast-swipe-movement-y))] [--peek:0.75rem] [--scale:calc(max(0,1-(var(--toast-index)*0.1)))] [--shrink:calc(1-var(--scale))] h-(--height) [transform:translateX(var(--toast-swipe-movement-x))_translateY(calc(var(--toast-swipe-movement-y)-(var(--toast-index)*var(--peek))-(var(--shrink)*var(--height))))_scale(var(--scale))] [transition:transform_500ms_cubic-bezier(0.22,1,0.36,1),opacity_500ms,height_150ms] after:absolute after:top-full after:left-0 after:h-[calc(var(--gap)+1px)] after:w-full after:content-[''] data-expanded:h-(--toast-height) data-expanded:[transform:translateX(var(--toast-swipe-movement-x))_translateY(var(--offset-y))] data-limited:opacity-0 data-starting-style:[transform:translateY(150%)] [&[data-ending-style]:not([data-limited]):not([data-swipe-direction])]:[transform:translateY(150%)] data-ending-style:data-[swipe-direction=down]:[transform:translateY(calc(var(--toast-swipe-movement-y)+150%))] data-ending-style:data-[swipe-direction=left]:[transform:translateX(calc(var(--toast-swipe-movement-x)-150%))_translateY(var(--offset-y))] data-ending-style:data-[swipe-direction=right]:[transform:translateX(calc(var(--toast-swipe-movement-x)+150%))_translateY(var(--offset-y))] data-ending-style:data-[swipe-direction=up]:[transform:translateY(calc(var(--toast-swipe-movement-y)-150%))] data-expanded:data-ending-style:data-[swipe-direction=down]:[transform:translateY(calc(var(--toast-swipe-movement-y)+150%))] data-expanded:data-ending-style:data-[swipe-direction=left]:[transform:translateX(calc(var(--toast-swipe-movement-x)-150%))_translateY(var(--offset-y))] data-expanded:data-ending-style:data-[swipe-direction=right]:[transform:translateX(calc(var(--toast-swipe-movement-x)+150%))_translateY(var(--offset-y))] data-expanded:data-ending-style:data-[swipe-direction=up]:[transform:translateY(calc(var(--toast-swipe-movement-y)-150%))]",
        className,
      )}
    >
      {children->Option.getOr(React.null)}
    </BaseUi.Toast.Root>
}

module Content = {
  @react.componentWithProps(BaseUi.Types.BaseUIComponentProps.t)
  let make = (props: BaseUi.Types.BaseUIComponentProps.t) =>
    <BaseUi.Toast.Content
      {...props}
      dataSlot="toast-content"
      className={cn(
        "flex h-full items-center gap-3 overflow-hidden p-4 transition-opacity duration-250 ease-[cubic-bezier(0.22,1,0.36,1)] data-behind:opacity-0 data-expanded:opacity-100",
        props.className,
      )}
    />
}

module Title = {
  @react.componentWithProps(BaseUi.Types.BaseUIComponentProps.t)
  let make = (props: BaseUi.Types.BaseUIComponentProps.t) =>
    <BaseUi.Toast.Title
      {...props} dataSlot="toast-title" className={cn("text-sm font-medium", props.className)}
    />
}

module Description = {
  @react.componentWithProps(BaseUi.Types.BaseUIComponentProps.t)
  let make = (props: BaseUi.Types.BaseUIComponentProps.t) =>
    <BaseUi.Toast.Description
      {...props}
      dataSlot="toast-description"
      className={cn("text-muted-foreground text-sm", props.className)}
    />
}

module Action = {
  @react.componentWithProps(BaseUi.Types.BaseUIComponentProps.t)
  let make = (props: BaseUi.Types.BaseUIComponentProps.t) =>
    <BaseUi.Toast.Action
      {...props}
      render={props.render->Option.getOr(<Button variant=Outline size=Sm />)}
      dataSlot="toast-action"
      className={cn("shrink-0", props.className)}
    />
}

module Close = {
  @react.componentWithProps(BaseUi.Types.BaseUIComponentProps.t)
  let make = (props: BaseUi.Types.BaseUIComponentProps.t) =>
    <BaseUi.Toast.Close
      {...props}
      render={props.render->Option.getOr(<Button variant=Ghost size=IconSm />)}
      dataSlot="toast-close"
      ariaLabel="Close toast"
      className={cn(
        "text-muted-foreground hover:text-foreground relative shrink-0 after:absolute after:-inset-2 after:content-['']",
        props.className,
      )}
    >
      {props.children->Option.getOr(<Icons.X ariaHidden=true />)}
    </BaseUi.Toast.Close>
}

module Icon = {
  @react.component
  let make = (~type_: option<string>=?) => {
    let icon = switch type_ {
    | Some("success") => <Icons.CircleCheck ariaHidden=true />
    | Some("info") => <Icons.Info ariaHidden=true />
    | Some("warning") => <Icons.TriangleAlert ariaHidden=true />
    | Some("error") => <Icons.OctagonX className="text-destructive" ariaHidden=true />
    | Some("loading") => <Icons.Loader2 className="animate-spin" ariaHidden=true />
    | _ => React.null
    }
    if icon == React.null {
      React.null
    } else {
      <span
        dataSlot="toast-icon"
        className="shrink-0 [&_svg]:pointer-events-none [&_svg:not([class*='size-'])]:size-4"
      >
        {icon}
      </span>
    }
  }
}

module List = {
  @react.component
  let make = () => {
    let {toasts} = useToastManager()
    toasts
    ->Array.map(item =>
      <Root key=item.id toast=item>
        <Content>
          <Icon type_=?item.type_ />
          <div className="flex min-w-0 flex-1 flex-col gap-1">
            <Title />
            <Description />
          </div>
          <Action />
          <Close />
        </Content>
      </Root>
    )
    ->React.array
  }
}

module Toaster = {
  @react.component
  let make = (~children=?, ~toastManager=toast, ~timeout=?, ~limit=?) =>
    <Provider toastManager ?timeout ?limit>
      {children->Option.getOr(React.null)}
      <Portal>
        <Viewport> <List /> </Viewport>
      </Portal>
    </Provider>
}

let make = Root.make
