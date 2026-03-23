module Align: {
  @unboxed
  type t =
    | @as("center") Center
    | @as("start") Start
    | @as("end") End
}

@react.component
let make: (
  ~className: string=?,
  ~previewClassName: string=?,
  ~align: Align.t=?,
  ~hideCode: bool=?,
  ~chromeLessOnMobile: bool=?,
  ~component: React.element,
  ~source: React.element,
  ~sourcePreview: React.element,
  ~direction: BaseUi.Types.TextDirection.t=?,
) => BaseUi.BaseUiJsxDOM.element
