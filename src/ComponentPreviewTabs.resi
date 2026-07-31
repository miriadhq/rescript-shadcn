module Align: {
  @unboxed
  type t =
    | @as("center") Center
    | @as("start") Start
    | @as("end") End
}

module StyleSource: {
  type t = {
    lib: Config.Lib.t,
    style: Config.Style.t,
    source: React.element,
    sourcePreview: React.element,
  }
}

@react.component
let make: (
  ~className: string=?,
  ~previewClassName: string=?,
  ~align: Align.t=?,
  ~hideCode: bool=?,
  ~chromeLessOnMobile: bool=?,
  ~component: React.element,
  ~sources: array<StyleSource.t>,
  ~direction: BaseUi.Types.TextDirection.t=?,
) => BaseUi.BaseUiJsxDOM.element
