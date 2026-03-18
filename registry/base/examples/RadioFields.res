@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Field.Group>
    <Field.Set>
      <Field.Legend variant=Field.Variant.Label> {"Subscription Plan"->React.string} </Field.Legend>
      <RadioGroup defaultValue="free">
        <Field orientation=BaseUi.Types.Orientation.Horizontal>
          <RadioGroup.Item value="free" id="radio-free" />
          <Field.Label htmlFor="radio-free" className="font-normal">
            {"Free Plan"->React.string}
          </Field.Label>
        </Field>
        <Field orientation=BaseUi.Types.Orientation.Horizontal>
          <RadioGroup.Item value="pro" id="radio-pro" />
          <Field.Label htmlFor="radio-pro" className="font-normal">
            {"Pro Plan"->React.string}
          </Field.Label>
        </Field>
        <Field orientation=BaseUi.Types.Orientation.Horizontal>
          <RadioGroup.Item value="enterprise" id="radio-enterprise" />
          <Field.Label htmlFor="radio-enterprise" className="font-normal">
            {"Enterprise"->React.string}
          </Field.Label>
        </Field>
      </RadioGroup>
    </Field.Set>
    <Field.Set>
      <Field.Legend variant=Field.Variant.Label> {"Battery Level"->React.string} </Field.Legend>
      <Field.Description>
        {"Choose your preferred battery level."->React.string}
      </Field.Description>
      <RadioGroup>
        <Field orientation=BaseUi.Types.Orientation.Horizontal>
          <RadioGroup.Item value="high" id="battery-high" />
          <Field.Label htmlFor="battery-high"> {"High"->React.string} </Field.Label>
        </Field>
        <Field orientation=BaseUi.Types.Orientation.Horizontal>
          <RadioGroup.Item value="medium" id="battery-medium" />
          <Field.Label htmlFor="battery-medium"> {"Medium"->React.string} </Field.Label>
        </Field>
        <Field orientation=BaseUi.Types.Orientation.Horizontal>
          <RadioGroup.Item value="low" id="battery-low" />
          <Field.Label htmlFor="battery-low"> {"Low"->React.string} </Field.Label>
        </Field>
      </RadioGroup>
    </Field.Set>
    <RadioGroup className="gap-6">
      <Field orientation=BaseUi.Types.Orientation.Horizontal>
        <RadioGroup.Item value="option1" id="radio-content-1" />
        <Field.Content>
          <Field.Label htmlFor="radio-content-1"> {"Enable Touch ID"->React.string} </Field.Label>
          <Field.Description>
            {"Enable Touch ID to quickly unlock your device."->React.string}
          </Field.Description>
        </Field.Content>
      </Field>
      <Field orientation=BaseUi.Types.Orientation.Horizontal>
        <RadioGroup.Item value="option2" id="radio-content-2" />
        <Field.Content>
          <Field.Label htmlFor="radio-content-2">
            {"Enable Touch ID and Face ID to make it even faster to unlock your device. This is a long label to test the layout."->React.string}
          </Field.Label>
          <Field.Description>
            {"Enable Touch ID to quickly unlock your device."->React.string}
          </Field.Description>
        </Field.Content>
      </Field>
    </RadioGroup>
    <RadioGroup className="gap-3">
      <Field.Label htmlFor="radio-title-1">
        <Field orientation=BaseUi.Types.Orientation.Horizontal>
          <RadioGroup.Item value="title1" id="radio-title-1" />
          <Field.Content>
            <Field.Title> {"Enable Touch ID"->React.string} </Field.Title>
            <Field.Description>
              {"Enable Touch ID to quickly unlock your device."->React.string}
            </Field.Description>
          </Field.Content>
        </Field>
      </Field.Label>
      <Field.Label htmlFor="radio-title-2">
        <Field orientation=BaseUi.Types.Orientation.Horizontal>
          <RadioGroup.Item value="title2" id="radio-title-2" />
          <Field.Content>
            <Field.Title>
              {"Enable Touch ID and Face ID to make it even faster to unlock your device. This is a long label to test the layout."->React.string}
            </Field.Title>
            <Field.Description>
              {"Enable Touch ID to quickly unlock your device."->React.string}
            </Field.Description>
          </Field.Content>
        </Field>
      </Field.Label>
    </RadioGroup>
    <Field.Set>
      <Field.Legend variant=Field.Variant.Label>
        {"Invalid Radio Group"->React.string}
      </Field.Legend>
      <RadioGroup>
        <Field dataInvalid={true} orientation=BaseUi.Types.Orientation.Horizontal>
          <RadioGroup.Item value="invalid1" id="radio-invalid-1" ariaInvalid={true} />
          <Field.Label htmlFor="radio-invalid-1"> {"Invalid Option 1"->React.string} </Field.Label>
        </Field>
        <Field dataInvalid={true} orientation=BaseUi.Types.Orientation.Horizontal>
          <RadioGroup.Item value="invalid2" id="radio-invalid-2" ariaInvalid={true} />
          <Field.Label htmlFor="radio-invalid-2"> {"Invalid Option 2"->React.string} </Field.Label>
        </Field>
      </RadioGroup>
    </Field.Set>
    <Field.Set>
      <Field.Legend variant=Field.Variant.Label>
        {"Disabled Radio Group"->React.string}
      </Field.Legend>
      <RadioGroup disabled={true}>
        <Field dataDisabled={true} orientation=BaseUi.Types.Orientation.Horizontal>
          <RadioGroup.Item value="disabled1" id="radio-disabled-1" disabled={true} />
          <Field.Label htmlFor="radio-disabled-1">
            {"Disabled Option 1"->React.string}
          </Field.Label>
        </Field>
        <Field dataDisabled={true} orientation=BaseUi.Types.Orientation.Horizontal>
          <RadioGroup.Item value="disabled2" id="radio-disabled-2" disabled={true} />
          <Field.Label htmlFor="radio-disabled-2">
            {"Disabled Option 2"->React.string}
          </Field.Label>
        </Field>
      </RadioGroup>
    </Field.Set>
  </Field.Group>
