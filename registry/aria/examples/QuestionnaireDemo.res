@@directive("'use client'")
@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

type formData
@get external currentForm: JsxEvent.Form.t => Dom.element = "currentTarget"
@new external formData: Dom.element => formData = "FormData"
@send external get: (formData, string) => nullable<string> = "get"
@send external getAll: (formData, string) => array<string> = "getAll"

let items: array<ShadcnReact.Questionnaire.itemDefinition> = [
  {
    choices: [{value: "tool-calls"}, {value: "approvals"}, {value: "handoffs"}],
    name: "direction",
    required: true,
  },
  {
    choices: [{value: "progress"}, {value: "decisions"}, {value: "risks"}, {value: "next-step"}],
    name: "signals",
  },
  {
    choices: [{value: "now"}, {value: "next-cycle"}, {value: "backlog"}],
    name: "timing",
    required: true,
  },
]

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let handleSubmit = event => {
    event->JsxEvent.Form.preventDefault
    let data = event->currentForm->formData
    let directionAnswer = data->get("direction")->Nullable.toOption->Option.getOr("None")
    let signalsAnswer = {
      let values = data->getAll("signals")->Array.join(", ")
      values == "" ? "None" : values
    }
    let timingAnswer = data->get("timing")->Nullable.toOption->Option.getOr("None")
    Sonner.toast(
      React.string("Agent plan saved"),
      ~options={
        description: React.string(
          `Direction: ${directionAnswer} · Progress signals: ${signalsAnswer} · Timing: ${timingAnswer}`,
        ),
      },
    )
  }
  <Questionnaire
    className="mx-auto max-w-md"
    defaultItem="direction"
    items={items}
    shortcuts=#letters
    onSubmit={handleSubmit}
  >
    <Questionnaire.Progress />
    <Questionnaire.Item name="direction" required=true>
      <Questionnaire.Title>
        {React.string("What should the agent build next?")}
      </Questionnaire.Title>
      <Questionnaire.Description>
        {React.string("Choose a direction or describe another task.")}
      </Questionnaire.Description>
      <Questionnaire.Choices>
        <Questionnaire.Choice value="tool-calls">
          <span className="font-medium"> {React.string("Tool call timeline")} </span>
          <span className="text-muted-foreground">
            {React.string("Show what the agent ran and what came back.")}
          </span>
        </Questionnaire.Choice>
        <Questionnaire.Choice value="approvals">
          <span className="font-medium"> {React.string("Approval checkpoints")} </span>
          <span className="text-muted-foreground">
            {React.string("Ask before sensitive or destructive actions.")}
          </span>
        </Questionnaire.Choice>
        <Questionnaire.Choice value="handoffs">
          <span className="font-medium"> {React.string("Sub-agent handoffs")} </span>
          <span className="text-muted-foreground">
            {React.string("Make delegated work and results easier to follow.")}
          </span>
        </Questionnaire.Choice>
        <Questionnaire.Input
          ariaLabel="Another agent feature" placeholder="Describe another feature…"
        />
      </Questionnaire.Choices>
      <Questionnaire.Error />
    </Questionnaire.Item>
    <Questionnaire.Item name="signals" multiple=true>
      <Questionnaire.Title>
        {React.string("What should every progress update include?")}
      </Questionnaire.Title>
      <Questionnaire.Description>
        {React.string("Select all that apply, or skip this question.")}
      </Questionnaire.Description>
      <Questionnaire.Choices>
        <Questionnaire.Choice value="progress"> {React.string("Progress")} </Questionnaire.Choice>
        <Questionnaire.Choice value="decisions"> {React.string("Decisions")} </Questionnaire.Choice>
        <Questionnaire.Choice value="risks"> {React.string("Risks")} </Questionnaire.Choice>
        <Questionnaire.Choice value="next-step"> {React.string("Next step")} </Questionnaire.Choice>
      </Questionnaire.Choices>
      <Questionnaire.Error />
    </Questionnaire.Item>
    <Questionnaire.Item name="timing" required=true>
      <Questionnaire.Title> {React.string("When should work begin?")} </Questionnaire.Title>
      <Questionnaire.Description>
        {React.string("Choose when the agent should begin the work.")}
      </Questionnaire.Description>
      <Questionnaire.Choices>
        <Questionnaire.Choice value="now"> {React.string("Start now")} </Questionnaire.Choice>
        <Questionnaire.Choice value="next-cycle">
          {React.string("Next development cycle")}
        </Questionnaire.Choice>
        <Questionnaire.Choice value="backlog">
          {React.string("Add it to the backlog")}
        </Questionnaire.Choice>
      </Questionnaire.Choices>
      <Questionnaire.Error />
    </Questionnaire.Item>
    <Questionnaire.Actions>
      <Questionnaire.Previous />
      <Questionnaire.Skip />
      <Questionnaire.Next> {React.string("Next")} </Questionnaire.Next>
      <Questionnaire.Submit> {React.string("Save plan")} </Questionnaire.Submit>
    </Questionnaire.Actions>
  </Questionnaire>
}
