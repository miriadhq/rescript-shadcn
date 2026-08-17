/** Shared types used by the React Aria bindings and their JSX runtime. */
module Orientation = {
  @unboxed
  type t =
    | @as("horizontal") Horizontal
    | @as("vertical") Vertical
}

module DataProps = {
  type t = {
    @as("data-slot") dataSlot?: string,
    @as("data-sidebar") dataSidebar?: string,
    @as("data-side") dataSide?: string,
    @as("data-align") dataAlign?: string,
    @as("data-icon") dataIcon?: string,
    @as("data-mobile") dataMobile?: string,
    @as("data-chips") dataChips?: bool,
    @as("data-chromeless") dataChromeless?: bool,
    @as("data-collapsible") dataCollapsible?: string,
    @as("data-mobile-code-visible") dataMobileCodeVisible?: bool,
    @as("data-content") dataContent?: bool,
    @as("data-disabled") dataDisabled?: bool,
    @as("data-invalid") dataInvalid?: bool,
    @as("data-chart") dataChart?: string,
    @as("data-day") dataDay?: string,
    @as("data-active") dataActive?: bool,
    @as("data-selected") dataSelected?: bool,
    @as("data-selected-single") dataSelectedSingle?: bool,
    @as("data-range-start") dataRangeStart?: bool,
    @as("data-range-end") dataRangeEnd?: bool,
    @as("data-range-middle") dataRangeMiddle?: bool,
    @as("data-size") dataSize?: string,
    @as("data-variant") dataVariant?: string,
    @as("data-empty") dataEmpty?: bool,
    @as("data-state") dataState?: string,
    @as("data-mode") dataMode?: string,
    @as("data-week-numbers") dataWeekNumbers?: bool,
    @as("data-multiple-months") dataMultipleMonths?: bool,
    @as("data-orientation") dataOrientation?: string,
    @as("data-align-trigger") dataAlignTrigger?: bool,
    @as("data-spacing") dataSpacing?: float,
    @as("data-inset") dataInset?: bool,
    @as("data-lang") dataLang?: string,
    @as("data-rehype-pretty-code-figure") dataRehypePrettyCodeFigure?: string,
    @as("data-rehype-pretty-code-title") dataRehypePrettyCodeTitle?: string,
    @as("data-language") dataLanguage?: string,
    @as("data-hide-code") dataHideCode?: bool,
  }
}

module DomProps = {
  type t = {
    onKeyDownCapture?: JsxEvent.Keyboard.t => unit,
    ...JsxDOM.domProps,
    ...DataProps.t,
  }
}
