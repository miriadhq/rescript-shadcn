@react.component
let make = () =>
  <div className="flex flex-col items-center gap-4">
    <p className="text-muted-foreground text-sm">
      {"Use "->React.string}
      <Kbd.Group>
        <Kbd> {"Ctrl + B"->React.string} </Kbd>
        <Kbd> {"Ctrl + K"->React.string} </Kbd>
      </Kbd.Group>
      {" to open the command palette"->React.string}
    </p>
  </div>
