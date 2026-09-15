@@directive("'use client'")

@unboxed type ease = Name(string) | Curve(array<float>)

type transition = {
  duration?: float,
  ease?: ease,
  @as("type") type_?: string,
  stiffness?: float,
  damping?: float,
  mass?: float,
}
type animation = {
  opacity?: float,
  x?: float,
  y?: float,
  scale?: float,
  originX?: float,
  originY?: float,
  filter?: string,
  transition?: transition,
}
type variants = {initial: animation, animate: animation, exit: animation}
type preset = {id: string, name: string, variants: variants}
@unboxed type initial = Disabled(bool) | Label(string)
type motionProps = {
  ...ShadcnReact.MessageScroller.Item.props,
  variants?: variants,
  initial: initial,
  animate?: string,
  exit?: string,
}
@module("motion/react") @scope("motion")
external motion: React.component<ShadcnReact.MessageScroller.Item.props> => React.component<
  motionProps,
> = "create"
@module("motion/react") external useReducedMotion: unit => nullable<bool> = "useReducedMotion"
module Item = {
  let make = motion(MessageScroller.Item.make)
}

let presets: array<preset> = [
  {
    id: "fade",
    name: "Fade",
    variants: {
      initial: {opacity: 0.},
      animate: {opacity: 1., transition: {duration: 0.22, ease: Name("easeOut")}},
      exit: {opacity: 0., transition: {duration: 0.15}},
    },
  },
  {
    id: "slide-up",
    name: "Slide Up",
    variants: {
      initial: {opacity: 0., y: 10.},
      animate: {opacity: 1., y: 0., transition: {duration: 0.26, ease: Curve([0.16, 1., 0.3, 1.])}},
      exit: {opacity: 0., y: 4., transition: {duration: 0.15}},
    },
  },
  {
    id: "slide-side",
    name: "Slide Side",
    variants: {
      initial: {opacity: 0., x: 18.},
      animate: {opacity: 1., x: 0., transition: {duration: 0.28, ease: Curve([0.16, 1., 0.3, 1.])}},
      exit: {opacity: 0., x: 8., transition: {duration: 0.15}},
    },
  },
  {
    id: "pop",
    name: "Pop",
    variants: {
      initial: {opacity: 0., scale: 0.94, y: 6., originX: 1., originY: 1.},
      animate: {
        opacity: 1.,
        y: 0.,
        scale: 1.,
        transition: {type_: "spring", stiffness: 500., damping: 34., mass: 0.7},
      },
      exit: {opacity: 0., scale: 0.98, transition: {duration: 0.12}},
    },
  },
  {
    id: "spring-bounce",
    name: "Spring Bounce",
    variants: {
      initial: {opacity: 0., y: 12., scale: 0.96},
      animate: {
        opacity: 1.,
        y: 0.,
        scale: 1.,
        transition: {type_: "spring", stiffness: 520., damping: 30., mass: 0.7},
      },
      exit: {opacity: 0., scale: 0.98, transition: {duration: 0.12}},
    },
  },
  {
    id: "blur-fade",
    name: "Blur Fade",
    variants: {
      initial: {opacity: 0., filter: "blur(4px)", y: 6.},
      animate: {
        opacity: 1.,
        y: 0.,
        filter: "blur(0px)",
        transition: {duration: 0.28, ease: Name("easeOut")},
      },
      exit: {opacity: 0., filter: "blur(2px)", transition: {duration: 0.15}},
    },
  },
  {
    id: "scale-fade",
    name: "Scale Fade",
    variants: {
      initial: {opacity: 0., scale: 0.98},
      animate: {opacity: 1., scale: 1., transition: {duration: 0.24, ease: Name("easeOut")}},
      exit: {opacity: 0., scale: 0.99, transition: {duration: 0.12}},
    },
  },
]

let preset = id => presets->Array.find(p => p.id == id)->Option.getOr(presets->Array.getUnsafe(1))

@react.component
let make = (
  ~message: AiChat.message,
  ~animationPreset=preset("slide-up"),
  ~scrollAnchor=?,
  ~userVariant=Bubble.Variant.Muted,
  ~assistantVariant=Bubble.Variant.Ghost,
) => {
  let reduced = useReducedMotion()->Nullable.getOr(false)
  let isUser = message.role == User
  <Item
    messageId={message.id}
    scrollAnchor=?{scrollAnchor->Option.orElse(isUser ? Some(true) : None)}
    variants=?{isUser ? Some(animationPreset.variants) : None}
    initial={isUser && !reduced ? Label("initial") : Disabled(false)}
    animate=?{isUser ? Some("animate") : None}
    exit=?{isUser && !reduced ? Some("exit") : None}
  >
    <Message align={isUser ? End : Start}>
      <Message.Content>
        {message.parts
        ->Array.mapWithIndex((part, index) => {
          let key = `${message.id}-${index->Int.toString}`
          switch part.type_ {
          | "reasoning" | "thinking" =>
            <div
              key
              className="w-full border-l-2 border-muted-foreground/30 pl-3 text-muted-foreground"
            >
              <div className="mb-1 flex items-center gap-1.5 text-xs font-medium">
                <Icons.Brain className="size-3.5" />
                {React.string("Reasoning")}
              </div>
              <div className="space-y-1.5 text-sm">
                {part->AiChat.partText->MessageScrollerExample.paragraphs}
              </div>
            </div>
          | "text" =>
            <Bubble key variant={isUser ? userVariant : assistantVariant}>
              <Bubble.Content className="space-y-2">
                {part->AiChat.partText->MessageScrollerExample.paragraphs}
              </Bubble.Content>
            </Bubble>
          | _ => React.null
          }
        })
        ->React.array}
      </Message.Content>
    </Message>
  </Item>
}
