module ClientRectObject = {
  type t = {
    x: float,
    y: float,
    width: float,
    height: float,
    top: float,
    right: float,
    bottom: float,
    left: float,
  }
}

module VirtualElement = {
  type t = {
    getBoundingClientRect: unit => ClientRectObject.t,
  }
}

module Rect = {
  type t = {
    x: float,
    y: float,
    width: float,
    height: float,
  }
}

module Padding = {
  type t = {
    top?: float,
    right?: float,
    bottom?: float,
    left?: float,
  }
}

module Boundary = {
  @unboxed
  type t =
    | @as("clipping-ancestors") ClippingAncestors
    | Elements(array<Dom.element>)
    | Rect(Rect.t)
}

module CollisionAvoidance = {
  type t = {
    side?: [#flip | #none | #shift],
    align?: [#flip | #shift | #none],
    fallbackAxisSide?: [#start | #end | #none],
  }
}

module Offset = {
  type dimensions = {
    width: float,
    height: float,
  }
  type data = {
    side: Types.Side.t,
    align: Types.Align.t,
    anchor: dimensions,
    positioner: dimensions,
  }
  @unboxed
  type t =
    | Const(float)
    | Fn(data => float)
}

module SharedParameters = {
  type t = {
    anchor?: ReactDOM.domRef,
    positionMethod?: Types.PositionMethod.t,
    side?: Types.Side.t,
    sideOffset?: Offset.t,
    align?: Types.Align.t,
    alignOffset?: Offset.t,
    collisionBoundary?: Boundary.t,
    collisionPadding?: Padding.t,
    sticky?: bool,
    arrowPadding?: float,
    disableAnchorTracking?: bool,
    collisionAvoidance?: CollisionAvoidance.t,
  }
}
