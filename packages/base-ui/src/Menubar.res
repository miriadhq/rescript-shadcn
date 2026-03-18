type props = {
  loopFocus?: bool,
  modal?: bool,
  disabled?: bool,
  orientation?: Types.Orientation.t,
  className?: string,
  style?: ReactDOM.Style.t,
  render?: React.element,
  children?: React.element,
  ...Types.DataProps.t,
  ...Types.AriaProps.t,
}
@module("@base-ui/react/menubar")
external make: React.component<props> = "Menubar"
