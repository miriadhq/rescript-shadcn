@@directive("'use client'")

@module("tailwind-merge")
external cn: (string, option<string>) => string = "twMerge"

type plugin

@module("@streamdown/code")
external code: plugin = "code"

type plugins = {code: plugin}

module Streamdown = {
  type props = {
    children?: React.element,
    className?: string,
    controls?: bool,
    plugins?: plugins,
    @as("data-slot") dataSlot?: string,
  }

  @module("streamdown")
  external make: React.component<props> = "Streamdown"
}

@react.componentWithProps(Streamdown.props)
let make = (props: Streamdown.props) =>
  <Streamdown
    {...props}
    dataSlot="markdown"
    plugins={props.plugins->Option.getOr({code: code})}
    controls={props.controls->Option.getOr(false)}
    className={cn("cn-markdown w-full min-w-0 overflow-hidden", props.className)}
  />
