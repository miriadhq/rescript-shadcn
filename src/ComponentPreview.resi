module Type: {
  type t =
    | @as("block") Block
    | @as("component") Component
    | @as("example") Example
}
@react.component
let make: (
  ~name: option<string>,
  @as("type") ~type_: Type.t=?,
  ~className: string=?,
  ~previewClassName: string=?,
  ~align: RescriptShadcn.ComponentPreviewTabs.Align.t=?,
  ~hideCode: bool=?,
  ~chromeLessOnMobile: bool=?,
  ~direction: BaseUi.Types.TextDirection.t=?,
  ~caption: string=?,
) => Jsx.element
