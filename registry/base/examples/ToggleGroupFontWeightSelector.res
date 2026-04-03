@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (fontWeight, setFontWeight) = React.useState(() => "normal")

  <Field>
    <Field.Label> {"Font Weight"->React.string} </Field.Label>
    <ToggleGroup
      value={[fontWeight]}
      onValueChange={(value: array<string>, _) => setFontWeight(_ => value->Array.getUnsafe(0))}
      variant=Outline
      spacing=2.
      size=Lg
    >
      <ToggleGroup.Item
        value="light"
        ariaLabel="Light"
        className="flex size-16 flex-col items-center justify-center rounded-xl"
      >
        <span className="text-2xl leading-none font-light"> {"Aa"->React.string} </span>
        <span className="text-muted-foreground text-xs"> {"Light"->React.string} </span>
      </ToggleGroup.Item>
      <ToggleGroup.Item
        value="normal"
        ariaLabel="Normal"
        className="flex size-16 flex-col items-center justify-center rounded-xl"
      >
        <span className="text-2xl leading-none font-normal"> {"Aa"->React.string} </span>
        <span className="text-muted-foreground text-xs"> {"Normal"->React.string} </span>
      </ToggleGroup.Item>
      <ToggleGroup.Item
        value="medium"
        ariaLabel="Medium"
        className="flex size-16 flex-col items-center justify-center rounded-xl"
      >
        <span className="text-2xl leading-none font-medium"> {"Aa"->React.string} </span>
        <span className="text-muted-foreground text-xs"> {"Medium"->React.string} </span>
      </ToggleGroup.Item>
      <ToggleGroup.Item
        value="bold"
        ariaLabel="Bold"
        className="flex size-16 flex-col items-center justify-center rounded-xl"
      >
        <span className="text-2xl leading-none font-bold"> {"Aa"->React.string} </span>
        <span className="text-muted-foreground text-xs"> {"Bold"->React.string} </span>
      </ToggleGroup.Item>
    </ToggleGroup>
    <Field.Description>
      {"Use "->React.string}
      <code className="bg-muted rounded-md px-1 py-0.5 font-mono">
        {"font-"->React.string}
        {fontWeight->React.string}
      </code>
      {" to set the font weight."->React.string}
    </Field.Description>
  </Field>
}
