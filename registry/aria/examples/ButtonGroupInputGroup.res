@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (voiceEnabled, setVoiceEnabled) = React.useState(() => false)
  let placeholder = switch voiceEnabled {
  | true => "Record and send audio..."
  | false => "Send a message..."
  }

  <ButtonGroup className="[--radius:9999rem]">
    <ButtonGroup>
      <Button variant=Outline size=Icon>
        <Icons.Plus />
      </Button>
    </ButtonGroup>
    <ButtonGroup>
      <InputGroup>
        <InputGroup.Input placeholder disabled=voiceEnabled />
        <InputGroup.Addon align=InlineEnd>
          <Tooltip.Trigger>
            <InputGroup.Button
                onClick={_ => setVoiceEnabled(value => !value)}
                size=IconXs
                dataActive=voiceEnabled
                ariaPressed={voiceEnabled ? #"true" : #"false"}
                className="data-[active=true]:bg-orange-100 data-[active=true]:text-orange-700 dark:data-[active=true]:bg-orange-800 dark:data-[active=true]:text-orange-100"
            >
              <Icons.AudioLines />
            </InputGroup.Button>
            <Tooltip> {"Voice Mode"->React.string} </Tooltip>
          </Tooltip.Trigger>
        </InputGroup.Addon>
      </InputGroup>
    </ButtonGroup>
  </ButtonGroup>
}
