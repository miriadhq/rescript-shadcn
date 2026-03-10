@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <blockquote className="mt-6 border-l-2 pl-6 italic">
    {"\"After all,\" he said, \"everyone enjoys a good joke, so it's only fair that they should pay for the privilege.\""->React.string}
  </blockquote>
