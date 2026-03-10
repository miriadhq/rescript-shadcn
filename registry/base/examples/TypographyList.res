@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <ul className="my-6 ml-6 list-disc [&>li]:mt-2">
    <li> {"1st level of puns: 5 gold coins"->React.string} </li>
    <li> {"2nd level of jokes: 10 gold coins"->React.string} </li>
    <li> {"3rd level of one-liners : 20 gold coins"->React.string} </li>
  </ul>
