@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (fontWeight, setFontWeight) = React.useState(() => "normal")

  <Field>
    <Field.Label> {"Font Weight"->React.string} </Field.Label>
    <ToggleGroup
      selectedKeys={[fontWeight]}
      onSelectionChange={value =>
        setFontWeight(_ =>
          value->Set.values->IteratorObject.toArray->Array.get(0)->Option.getOr("normal")
        )}
      variant=Outline
      spacing=2.
      size=Lg
    >
      <ToggleGroup.Item
        id="light"
        ariaLabel="Light"
        className="flex size-16 flex-col items-center justify-center rounded-xl"
      >
        <span className="text-2xl leading-none font-light"> {"Aa"->React.string} </span>
        <span className="text-muted-foreground text-xs"> {"Light"->React.string} </span>
      </ToggleGroup.Item>
      <ToggleGroup.Item
        id="normal"
        ariaLabel="Normal"
        className="flex size-16 flex-col items-center justify-center rounded-xl"
      >
        <span className="text-2xl leading-none font-normal"> {"Aa"->React.string} </span>
        <span className="text-muted-foreground text-xs"> {"Normal"->React.string} </span>
      </ToggleGroup.Item>
      <ToggleGroup.Item
        id="medium"
        ariaLabel="Medium"
        className="flex size-16 flex-col items-center justify-center rounded-xl"
      >
        <span className="text-2xl leading-none font-medium"> {"Aa"->React.string} </span>
        <span className="text-muted-foreground text-xs"> {"Medium"->React.string} </span>
      </ToggleGroup.Item>
      <ToggleGroup.Item
        id="bold"
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
