/** Shared types for Base UI ReScript bindings. */
type eventDetails = JSON.t

module Side = {
  @unboxed
  type t =
    | @as("top") Top
    | @as("bottom") Bottom
    | @as("left") Left
    | @as("right") Right
    | @as("inline-start") InlineStart
    | @as("inline-end") InlineEnd
}

module Align = {
  @unboxed
  type t =
    | @as("start") Start
    | @as("center") Center
    | @as("end") End
}

module Orientation = {
  @unboxed
  type t =
    | @as("horizontal") Horizontal
    | @as("vertical") Vertical
}

module Modal = {
  @unboxed
  type t =
    | Bool(bool)
    | @as("trap-focus") TrapFocus
}

module CheckedState = {
  @unboxed
  type t =
    | Checked(bool)
    | @as("indeterminate") Indeterminate
}

module PositionMethod = {
  @unboxed
  type t =
    | @as("absolute") Absolute
    | @as("fixed") Fixed
}

module ThumbAlignment = {
  @unboxed
  type t =
    | @as("center") Center
    | @as("edge") Edge
    | @as("edge-client-only") EdgeClientOnly
}

module ThumbCollisionBehavior = {
  @unboxed
  type t =
    | @as("push") Push
    | @as("swap") Swap
    | @as("none") None
}

module TextDirection = {
  @unboxed
  type t =
    | @as("ltr") Ltr
    | @as("rtl") Rtl
}

module DataOrientation = {
  @unboxed
  type t =
    | @as("horizontal") Horizontal
    | @as("vertical") Vertical
    | @as("responsive") Responsive
}

module BaseUIChangeEventDetail = {
  type t<'reason, 'nativeEvent> = {
    reason: 'reason,
    event: 'nativeEvent,
    cancel: unit => unit,
    allowPropagation: unit => unit,
    isCanceled: bool,
    isPropagationAllowed: bool,
    trigger: Dom.element,
  }
}

module OnlyTrue = {
  @unboxed
  type t = | @as(true) True
}
module OnlyFalse = {
  @unboxed
  type t = | @as(false) False
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
    @as("data-mobile-code-visible")
    dataMobileCodeVisible?: bool,
    @as("data-content") dataContent?: bool,
    @as("data-disabled") dataDisabled?: bool,
    @as("data-invalid") dataInvalid?: bool,
    @as("data-chart") dataChart?: string,
    @as("data-day") dataDay?: string,
    @as("data-active") dataActive?: bool,
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

module AriaProps = {
  type t = {
    /* accessibility */
    /* https://www.w3.org/TR/wai-aria-1.1/ */
    /* https://accessibilityresources.org/<aria-tag> is a great resource for these */
    @as("aria-current")
    ariaCurrent?: [#page | #step | #location | #date | #time | #"true" | #"false"],
    @as("aria-details")
    ariaDetails?: string,
    @as("aria-disabled")
    ariaDisabled?: bool,
    @as("aria-hidden")
    ariaHidden?: bool,
    @as("aria-invalid") ariaInvalid?: [#grammar | #"false" | #spelling | #"true"],
    @as("aria-keyshortcuts")
    ariaKeyshortcuts?: string,
    @as("aria-label")
    ariaLabel?: string,
    @as("aria-roledescription")
    ariaRoledescription?: string,
    /* Widget Attributes */
    @as("aria-autocomplete") ariaAutocomplete?: [#inline | #list | #both | #none],
    /* https://www.w3.org/TR/wai-aria-1.1/#valuetype_tristate */
    @as("aria-checked")
    ariaChecked?: [#"true" | #"false" | #mixed],
    @as("aria-expanded")
    ariaExpanded?: bool,
    @as("aria-haspopup")
    ariaHaspopup?: [#menu | #listbox | #tree | #grid | #dialog | #"true" | #"false"],
    @as("aria-level")
    ariaLevel?: int,
    @as("aria-modal")
    ariaModal?: bool,
    @as("aria-multiline")
    ariaMultiline?: bool,
    @as("aria-multiselectable")
    ariaMultiselectable?: bool,
    @as("aria-orientation") ariaOrientation?: [#horizontal | #vertical | #undefined],
    @as("aria-placeholder")
    ariaPlaceholder?: string,
    /* https://www.w3.org/TR/wai-aria-1.1/#valuetype_tristate */
    @as("aria-pressed") ariaPressed?: [#"true" | #"false" | #mixed],
    @as("aria-readonly")
    ariaReadonly?: bool,
    @as("aria-required")
    ariaRequired?: bool,
    @as("aria-selected")
    ariaSelected?: bool,
    @as("aria-sort")
    ariaSort?: string,
    @as("aria-valuemax")
    ariaValuemax?: float,
    @as("aria-valuemin")
    ariaValuemin?: float,
    @as("aria-valuenow")
    ariaValuenow?: float,
    @as("aria-valuetext")
    ariaValuetext?: string,
    /* Live Region Attributes */
    @as("aria-atomic")
    ariaAtomic?: bool,
    @as("aria-busy")
    ariaBusy?: bool,
    @as("aria-live") ariaLive?: [#off | #polite | #assertive | #rude],
    @as("aria-relevant")
    ariaRelevant?: string,
    /* Drag-and-Drop Attributes */
    @as("aria-dropeffect") ariaDropeffect?: [#copy | #move | #link | #execute | #popup | #none],
    @as("aria-grabbed")
    ariaGrabbed?: bool,
    /* Relationship Attributes */
    @as("aria-activedescendant")
    ariaActivedescendant?: string,
    @as("aria-colcount")
    ariaColcount?: int,
    @as("aria-colindex")
    ariaColindex?: int,
    @as("aria-colspan")
    ariaColspan?: int,
    @as("aria-controls")
    ariaControls?: string,
    @as("aria-describedby")
    ariaDescribedby?: string,
    @as("aria-errormessage")
    ariaErrormessage?: string,
    @as("aria-flowto")
    ariaFlowto?: string,
    @as("aria-labelledby")
    ariaLabelledby?: string,
    @as("aria-owns")
    ariaOwns?: string,
    @as("aria-posinset")
    ariaPosinset?: int,
    @as("aria-rowcount")
    ariaRowcount?: int,
    @as("aria-rowindex")
    ariaRowindex?: int,
    @as("aria-rowspan")
    ariaRowspan?: int,
    @as("aria-setsize")
    ariaSetsize?: int,
  }
}

module ExtraDomProps = {
  type t = {
    onKeyDownCapture?: JsxEvent.Keyboard.t => unit,
    suppressHydrationWarning?: bool,
    ...AriaProps.t,
    ...DataProps.t,
  }
}

type dangerouslySetInnerHTML = {"__html": string}

module BaseDomProps = {
  type t = {
    key?: string,
    children?: Jsx.element,
    ref?: ReactDOM.domRef,
    // https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/iframe#allow
    allow?: string,
    /* global html attributes */
    accessKey?: string,
    capture?: [#user | #environment],
    className?: string /* substitute for "class" */,
    contentEditable?: bool,
    contextMenu?: string,
    @as("data-testid") dataTestId?: string,
    dir?: string /* "ltr", "rtl" or "auto" */,
    draggable?: bool,
    hidden?: bool,
    id?: string,
    inert?: bool,
    lang?: string,
    popover?: JsxDOM.popover,
    popoverTarget?: string,
    popoverTargetAction?: JsxDOM.popoverTargetAction,
    role?: string /* ARIA role */,
    style?: JsxDOM.style,
    spellCheck?: bool,
    tabIndex?: int,
    title?: string,
    /* html5 microdata */
    itemID?: string,
    itemProp?: string,
    itemRef?: string,
    itemScope?: bool,
    itemType?: string /* uri */,
    /* tag-specific html attributes */
    accept?: string,
    acceptCharset?: string,
    action?: string /* uri */,
    allowFullScreen?: bool,
    alt?: string,
    @as("as")
    as_?: string,
    async?: bool,
    autoComplete?: string /* has a fixed, but large-ish, set of possible values */,
    autoCapitalize?: string /* Mobile Safari specific */,
    autoFocus?: bool,
    autoPlay?: bool,
    challenge?: string,
    charSet?: string,
    cite?: string /* uri */,
    crossOrigin?: string /* anonymous, use-credentials */,
    cols?: int,
    colSpan?: int,
    content?: string,
    controls?: bool,
    coords?: string /* set of values specifying the coordinates of a region */,
    data?: string /* uri */,
    dateTime?: string /* "valid date string with optional time" */,
    default?: bool,
    defer?: bool,
    disabled?: bool,
    download?: string /* should really be either a boolean, signifying presence, or a string */,
    encType?: string /* "application/x-www-form-urlencoded", "multipart/form-data" or "text/plain" */,
    form?: string,
    formAction?: string /* uri */,
    formTarget?: string /* "_blank", "_self", etc. */,
    formMethod?: string /* "post", "get", "put" */,
    // https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/iframe#frameborder
    frameBorder?: int /* "0", "1" */,
    headers?: string,
    height?: string /* in html5 this can only be a number, but in html4 it can ba a percentage as well */,
    high?: int,
    href?: string /* uri */,
    hrefLang?: string,
    htmlFor?: string /* substitute for "for" */,
    httpEquiv?: string /* has a fixed set of possible values */,
    icon?: string /* uri? */,
    inputMode?: string /* "verbatim", "latin", "numeric", etc. */,
    integrity?: string,
    keyType?: string,
    kind?: string /* has a fixed set of possible values */,
    label?: string,
    list?: string,
    loading?: [#lazy | #eager],
    loop?: bool,
    low?: int,
    manifest?: string /* uri */,
    max?: string /* should be int or Date.t */,
    maxLength?: int,
    media?: string /* a valid media query */,
    mediaGroup?: string,
    method?: string /* "post" or "get" */,
    min?: string,
    minLength?: int,
    muted?: bool,
    name?: string,
    nonce?: string,
    noValidate?: bool,
    @as("open")
    open_?: bool /* use this one. Previous one is deprecated */,
    optimum?: int,
    pattern?: string /* valid Js RegExp */,
    placeholder?: string,
    playsInline?: bool,
    poster?: string /* uri */,
    preload?: string /* "none", "metadata" or "auto" (and "" as a synonym for "auto") */,
    radioGroup?: string,
    readOnly?: bool,
    rel?: string /* a space- or comma-separated (depending on the element) list of a fixed set of "link types" */,
    required?: bool,
    reversed?: bool,
    rows?: int,
    rowSpan?: int,
    sandbox?: string /* has a fixed set of possible values */,
    scope?: string /* has a fixed set of possible values */,
    scoped?: bool,
    scrolling?: string /* html4 only, "auto", "yes" or "no" */,
    /* seamless - supported by React, but removed from the html5 spec */
    selected?: bool,
    shape?: string,
    sizes?: string,
    span?: int,
    src?: string /* uri */,
    srcDoc?: string,
    srcLang?: string,
    srcSet?: string,
    start?: int,
    step?: float,
    summary?: string /* deprecated */,
    target?: string,
    @as("type")
    type_?: string /* has a fixed but large-ish set of possible values */ /* use this one. Previous one is deprecated */,
    useMap?: string,
    width?: string /* in html5 this can only be a number, but in html4 it can ba a percentage as well */,
    wrap?: string /* "hard" or "soft" */,
    /* Clipboard events */
    onCopy?: JsxEvent.Clipboard.t => unit,
    onCut?: JsxEvent.Clipboard.t => unit,
    onPaste?: JsxEvent.Clipboard.t => unit,
    /* Composition events */
    onCompositionEnd?: JsxEvent.Composition.t => unit,
    onCompositionStart?: JsxEvent.Composition.t => unit,
    onCompositionUpdate?: JsxEvent.Composition.t => unit,
    /* Keyboard events */
    onKeyDown?: JsxEvent.Keyboard.t => unit,
    onKeyPress?: JsxEvent.Keyboard.t => unit,
    onKeyUp?: JsxEvent.Keyboard.t => unit,
    /* Focus events */
    onFocus?: JsxEvent.Focus.t => unit,
    onBlur?: JsxEvent.Focus.t => unit,
    /* Form events */
    onBeforeInput?: JsxEvent.Form.t => unit,
    onInput?: JsxEvent.Form.t => unit,
    onReset?: JsxEvent.Form.t => unit,
    onSubmit?: JsxEvent.Form.t => unit,
    onInvalid?: JsxEvent.Form.t => unit,
    /* Mouse events */
    onClick?: JsxEvent.Mouse.t => unit,
    onContextMenu?: JsxEvent.Mouse.t => unit,
    onDoubleClick?: JsxEvent.Mouse.t => unit,
    onDrag?: JsxEvent.Mouse.t => unit,
    onDragEnd?: JsxEvent.Mouse.t => unit,
    onDragEnter?: JsxEvent.Mouse.t => unit,
    onDragExit?: JsxEvent.Mouse.t => unit,
    onDragLeave?: JsxEvent.Mouse.t => unit,
    onDragOver?: JsxEvent.Mouse.t => unit,
    onDragStart?: JsxEvent.Mouse.t => unit,
    onDrop?: JsxEvent.Mouse.t => unit,
    onMouseDown?: JsxEvent.Mouse.t => unit,
    onMouseEnter?: JsxEvent.Mouse.t => unit,
    onMouseLeave?: JsxEvent.Mouse.t => unit,
    onMouseMove?: JsxEvent.Mouse.t => unit,
    onMouseOut?: JsxEvent.Mouse.t => unit,
    onMouseOver?: JsxEvent.Mouse.t => unit,
    onMouseUp?: JsxEvent.Mouse.t => unit,
    /* Selection events */
    onSelect?: JsxEvent.Selection.t => unit,
    /* Touch events */
    onTouchCancel?: JsxEvent.Touch.t => unit,
    onTouchEnd?: JsxEvent.Touch.t => unit,
    onTouchMove?: JsxEvent.Touch.t => unit,
    onTouchStart?: JsxEvent.Touch.t => unit,
    // Pointer events
    onPointerOver?: JsxEvent.Pointer.t => unit,
    onPointerEnter?: JsxEvent.Pointer.t => unit,
    onPointerDown?: JsxEvent.Pointer.t => unit,
    onPointerMove?: JsxEvent.Pointer.t => unit,
    onPointerUp?: JsxEvent.Pointer.t => unit,
    onPointerCancel?: JsxEvent.Pointer.t => unit,
    onPointerOut?: JsxEvent.Pointer.t => unit,
    onPointerLeave?: JsxEvent.Pointer.t => unit,
    onGotPointerCapture?: JsxEvent.Pointer.t => unit,
    onLostPointerCapture?: JsxEvent.Pointer.t => unit,
    /* UI events */
    onScroll?: JsxEvent.UI.t => unit,
    /* Wheel events */
    onWheel?: JsxEvent.Wheel.t => unit,
    /* Media events */
    onAbort?: JsxEvent.Media.t => unit,
    onCanPlay?: JsxEvent.Media.t => unit,
    onCanPlayThrough?: JsxEvent.Media.t => unit,
    onDurationChange?: JsxEvent.Media.t => unit,
    onEmptied?: JsxEvent.Media.t => unit,
    onEncrypted?: JsxEvent.Media.t => unit,
    onEnded?: JsxEvent.Media.t => unit,
    onError?: JsxEvent.Media.t => unit,
    onLoadedData?: JsxEvent.Media.t => unit,
    onLoadedMetadata?: JsxEvent.Media.t => unit,
    onLoadStart?: JsxEvent.Media.t => unit,
    onPause?: JsxEvent.Media.t => unit,
    onPlay?: JsxEvent.Media.t => unit,
    onPlaying?: JsxEvent.Media.t => unit,
    onProgress?: JsxEvent.Media.t => unit,
    onRateChange?: JsxEvent.Media.t => unit,
    onSeeked?: JsxEvent.Media.t => unit,
    onSeeking?: JsxEvent.Media.t => unit,
    onStalled?: JsxEvent.Media.t => unit,
    onSuspend?: JsxEvent.Media.t => unit,
    onTimeUpdate?: JsxEvent.Media.t => unit,
    onVolumeChange?: JsxEvent.Media.t => unit,
    onWaiting?: JsxEvent.Media.t => unit,
    /* Image events */
    onLoad?: JsxEvent.Image.t => unit /* duplicate */ /* ~onError: ReactEvent.Image.t => unit=?, */,
    /* Animation events */
    onAnimationStart?: JsxEvent.Animation.t => unit,
    onAnimationEnd?: JsxEvent.Animation.t => unit,
    onAnimationIteration?: JsxEvent.Animation.t => unit,
    /* Transition events */
    onTransitionEnd?: JsxEvent.Transition.t => unit,
    /* svg */
    accentHeight?: string,
    accumulate?: string,
    additive?: string,
    alignmentBaseline?: string,
    allowReorder?: string,
    alphabetic?: string,
    amplitude?: string,
    arabicForm?: string,
    ascent?: string,
    attributeName?: string,
    attributeType?: string,
    autoReverse?: string,
    azimuth?: string,
    baseFrequency?: string,
    baseProfile?: string,
    baselineShift?: string,
    bbox?: string,
    begin?: string,
    @deprecated("Please use begin")
    begin_?: string,
    bias?: string,
    by?: string,
    calcMode?: string,
    capHeight?: string,
    clip?: string,
    clipPath?: string,
    clipPathUnits?: string,
    clipRule?: string,
    colorInterpolation?: string,
    colorInterpolationFilters?: string,
    colorProfile?: string,
    colorRendering?: string,
    contentScriptType?: string,
    contentStyleType?: string,
    cursor?: string,
    cx?: string,
    cy?: string,
    d?: string,
    decelerate?: string,
    descent?: string,
    diffuseConstant?: string,
    direction?: string,
    display?: string,
    divisor?: string,
    dominantBaseline?: string,
    dur?: string,
    dx?: string,
    dy?: string,
    edgeMode?: string,
    elevation?: string,
    enableBackground?: string,
    end?: string,
    @deprecated("Please use end")
    end_?: string,
    exponent?: string,
    externalResourcesRequired?: string,
    fill?: string,
    fillOpacity?: string,
    fillRule?: string,
    filter?: string,
    filterRes?: string,
    filterUnits?: string,
    floodColor?: string,
    floodOpacity?: string,
    focusable?: string,
    fontFamily?: string,
    fontSize?: string,
    fontSizeAdjust?: string,
    fontStretch?: string,
    fontStyle?: string,
    fontVariant?: string,
    fontWeight?: string,
    fomat?: string,
    from?: string,
    fx?: string,
    fy?: string,
    g1?: string,
    g2?: string,
    glyphName?: string,
    glyphOrientationHorizontal?: string,
    glyphOrientationVertical?: string,
    glyphRef?: string,
    gradientTransform?: string,
    gradientUnits?: string,
    hanging?: string,
    horizAdvX?: string,
    horizOriginX?: string,
    ideographic?: string,
    imageRendering?: string,
    @as("in")
    in_?: string /* use this one. Previous one is deprecated */,
    in2?: string,
    intercept?: string,
    k?: string,
    k1?: string,
    k2?: string,
    k3?: string,
    k4?: string,
    kernelMatrix?: string,
    kernelUnitLength?: string,
    kerning?: string,
    keyPoints?: string,
    keySplines?: string,
    keyTimes?: string,
    lengthAdjust?: string,
    letterSpacing?: string,
    lightingColor?: string,
    limitingConeAngle?: string,
    local?: string,
    markerEnd?: string,
    markerHeight?: string,
    markerMid?: string,
    markerStart?: string,
    markerUnits?: string,
    markerWidth?: string,
    mask?: string,
    maskContentUnits?: string,
    maskUnits?: string,
    mathematical?: string,
    mode?: string,
    numOctaves?: string,
    offset?: string,
    opacity?: string,
    operator?: string,
    order?: string,
    orient?: string,
    orientation?: Orientation.t,
    origin?: string,
    overflow?: string,
    overflowX?: string,
    overflowY?: string,
    overlinePosition?: string,
    overlineThickness?: string,
    paintOrder?: string,
    panose1?: string,
    pathLength?: string,
    patternContentUnits?: string,
    patternTransform?: string,
    patternUnits?: string,
    pointerEvents?: string,
    points?: string,
    pointsAtX?: string,
    pointsAtY?: string,
    pointsAtZ?: string,
    preserveAlpha?: string,
    preserveAspectRatio?: string,
    primitiveUnits?: string,
    r?: string,
    radius?: string,
    // https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/iframe#referrerpolicy
    referrerPolicy?: string,
    refX?: string,
    refY?: string,
    renderingIntent?: string,
    repeatCount?: string,
    repeatDur?: string,
    requiredExtensions?: string,
    requiredFeatures?: string,
    restart?: string,
    result?: string,
    rotate?: string,
    rx?: string,
    ry?: string,
    scale?: string,
    seed?: string,
    shapeRendering?: string,
    slope?: string,
    slot?: string,
    spacing?: string,
    specularConstant?: string,
    specularExponent?: string,
    speed?: string,
    spreadMethod?: string,
    startOffset?: string,
    stdDeviation?: string,
    stemh?: string,
    stemv?: string,
    stitchTiles?: string,
    stopColor?: string,
    stopOpacity?: string,
    strikethroughPosition?: string,
    strikethroughThickness?: string,
    string?: string,
    stroke?: string,
    strokeDasharray?: string,
    strokeDashoffset?: string,
    strokeLinecap?: string,
    strokeLinejoin?: string,
    strokeMiterlimit?: string,
    strokeOpacity?: string,
    strokeWidth?: string,
    surfaceScale?: string,
    systemLanguage?: string,
    tableValues?: string,
    targetX?: string,
    targetY?: string,
    textAnchor?: string,
    textDecoration?: string,
    textLength?: string,
    textRendering?: string,
    to?: string,
    @deprecated("Please use to")
    to_?: string,
    transform?: string,
    u1?: string,
    u2?: string,
    underlinePosition?: string,
    underlineThickness?: string,
    unicode?: string,
    unicodeBidi?: string,
    unicodeRange?: string,
    unitsPerEm?: string,
    vAlphabetic?: string,
    vHanging?: string,
    vIdeographic?: string,
    vMathematical?: string,
    values?: string,
    vectorEffect?: string,
    version?: string,
    vertAdvX?: string,
    vertAdvY?: string,
    vertOriginX?: string,
    vertOriginY?: string,
    viewBox?: string,
    viewTarget?: string,
    visibility?: string,
    /* width::string? => */
    widths?: string,
    wordSpacing?: string,
    writingMode?: string,
    x?: string,
    x1?: string,
    x2?: string,
    xChannelSelector?: string,
    xHeight?: string,
    xlinkActuate?: string,
    xlinkArcrole?: string,
    xlinkHref?: string,
    xlinkRole?: string,
    xlinkShow?: string,
    xlinkTitle?: string,
    xlinkType?: string,
    xmlns?: string,
    xmlnsXlink?: string,
    xmlBase?: string,
    xmlLang?: string,
    xmlSpace?: string,
    y?: string,
    y1?: string,
    y2?: string,
    yChannelSelector?: string,
    z?: string,
    zoomAndPan?: string,
    /* RDFa */
    about?: string,
    datatype?: string,
    inlist?: string,
    prefix?: string,
    property?: string,
    resource?: string,
    typeof?: string,
    vocab?: string,
    /* react-specific */
    dangerouslySetInnerHTML?: dangerouslySetInnerHTML,
    suppressContentEditableWarning?: bool,
  }
}

module DomProps = {
  type t = {
    size?: int,
    onChange?: JsxEvent.Form.t => unit,
    multiple?: bool,
    checked?: bool,
    defaultChecked?: bool,
    value?: string,
    defaultValue?: string,
    ...BaseDomProps.t,
    ...ExtraDomProps.t,
  }
}

module BaseUIComponentProps = {
  type t = {
    render?: React.element,
    ...BaseDomProps.t,
    ...ExtraDomProps.t,
  }
}

module NativeButtonProps = {
  type t = {
    nativeButton?: bool,
  }
}

module NonNativeButtonProps = {
  type t = {
    nativeButton?: bool,
  }
}
