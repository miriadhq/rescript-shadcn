// Exercise the external module alias through a compiled ReScript caller.
module DirectionText = {
  @react.component
  let make = () => {
    let direction = Base.Direction.use()
    <span dir={(direction :> string)}> {React.string((direction :> string))} </span>
  }
}

@react.component
let make = () =>
  <Base.Direction.Provider direction=Rtl> <DirectionText /> </Base.Direction.Provider>
