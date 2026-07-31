module Props = {
  type t = {}
}

module type Component = {
  let make: Props.t => React.element
}
