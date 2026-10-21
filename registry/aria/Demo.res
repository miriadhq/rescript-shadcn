module Props = {
  type t = {}
}

module type Component = {
  let make: React.component<Props.t>
}
