@react.component
let make = (~children) => {
  <main className="overflow-auto w-full"> {children} </main>
}

let default = make
