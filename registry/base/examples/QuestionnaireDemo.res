@@directive("'use client'")
@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

type formData
@get external currentForm: JsxEvent.Form.t => Dom.element = "currentTarget"
@new external formData: Dom.element => formData = "FormData"
@send external get: (formData, string) => nullable<string> = "get"
@send external getAll: (formData, string) => array<string> = "getAll"

type choice = {description?: string, label: string, value: string}
type input = {label: string, placeholder: string}
type question = {
  choices: array<choice>,
  description: string,
  input?: input,
  name: string,
  required: bool,
  title: string,
  multiple?: bool,
}
let questions: array<question> = [
  {
    choices: [
      {
        description: "Show what the agent ran and what came back.",
        label: "Tool call timeline",
        value: "tool-calls",
      },
      {
        description: "Ask before sensitive or destructive actions.",
        label: "Approval checkpoints",
        value: "approvals",
      },
      {
        description: "Make delegated work and results easier to follow.",
        label: "Sub-agent handoffs",
        value: "handoffs",
      },
    ],
    description: "Choose a direction or describe another task.",
    input: {
      label: "Another agent feature",
      placeholder: "Describe another feature…",
    },
    name: "direction",
    required: true,
    title: "What should the agent build next?",
  },
  {
    choices: [
      {label: "Progress", value: "progress"},
      {label: "Decisions", value: "decisions"},
      {label: "Risks", value: "risks"},
      {label: "Next step", value: "next-step"},
    ],
    description: "Select all that apply, or skip this question.",
    multiple: true,
    name: "signals",
    required: false,
    title: "What should every progress update include?",
  },
  {
    choices: [
      {label: "Start now", value: "now"},
      {label: "Next development cycle", value: "next-cycle"},
      {label: "Add it to the backlog", value: "backlog"},
    ],
    description: "Choose when the agent should begin the work.",
    name: "timing",
    required: true,
    title: "When should work begin?",
  },
]
let items: array<ShadcnReact.Questionnaire.itemDefinition> = questions->Array.map((
  question
): ShadcnReact.Questionnaire.itemDefinition => {
  name: question.name,
  required: question.required,
  choices: question.choices->Array.map((choice): ShadcnReact.Questionnaire.choiceDefinition => {
    value: choice.value,
  }),
})

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
    {questions
    ->Array.map(question =>
      <Questionnaire.Item
        key={question.name}
        multiple={question.multiple->Option.getOr(false)}
        name={question.name}
        required={question.required}
      >
        <Questionnaire.Title> {React.string(question.title)} </Questionnaire.Title>
        <Questionnaire.Description>
          {React.string(question.description)}
        </Questionnaire.Description>
        <Questionnaire.Choices>
          {question.choices
          ->Array.map(choice =>
            <Questionnaire.Choice key={choice.value} value={choice.value}>
              <span className="font-medium"> {React.string(choice.label)} </span>
              {choice.description->Option.isSome
                ? <span className="text-muted-foreground">
                    {React.string(choice.description->Option.getOr(""))}
                  </span>
                : React.null}
            </Questionnaire.Choice>
          )
          ->React.array}
          {switch question.input {
          | Some(input) =>
            <Questionnaire.Input ariaLabel={input.label} placeholder={input.placeholder} />
          | None => React.null
          }}
        </Questionnaire.Choices>
        <Questionnaire.Error />
      </Questionnaire.Item>
    )
    ->React.array}
    <Questionnaire.Actions>
      <Questionnaire.Previous />
      <Questionnaire.Skip />
      <Questionnaire.Next> {React.string("Next")} </Questionnaire.Next>
      <Questionnaire.Submit> {React.string("Save plan")} </Questionnaire.Submit>
    </Questionnaire.Actions>
  </Questionnaire>
}
