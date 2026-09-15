@@directive("'use client'")
@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

type formData
@get external currentForm: JsxEvent.Form.t => Dom.element = "currentTarget"
@new external formData: Dom.element => formData = "FormData"
@send external get: (formData, string) => nullable<string> = "get"
@send external getAll: (formData, string) => array<string> = "getAll"

let items: array<ShadcnReact.Questionnaire.itemDefinition> = [
  {
    choices: [{value: "fix"}, {value: "refactor"}, {value: "docs"}],
    name: "task",
    required: true,
  },
  {
    choices: [{value: "summary"}, {value: "files"}, {value: "review"}],
    name: "output",
    required: true,
  },
]

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let taskTitleId = React.useId()
  let outputTitleId = React.useId()
  let handleSubmit = event => {
    event->JsxEvent.Form.preventDefault
    let data = event->currentForm->formData
    let taskAnswer = data->get("task")->Nullable.toOption->Option.getOr("None")
    let outputAnswer = data->get("output")->Nullable.toOption->Option.getOr("None")
    Sonner.toast(
      React.string("Agent task created"),
      ~options={description: React.string(`Task: ${taskAnswer} · Handoff: ${outputAnswer}`)},
    )
  }
  <Questionnaire
    className="mx-auto max-w-md"
    defaultItem="task"
    items={items}
    shortcuts=#numbers
    onSubmit={handleSubmit}
  >
    <Card>
      <Questionnaire.Item ariaLabelledby={taskTitleId} name="task" required=true>
        <Card.Header>
          <Questionnaire.Title id={taskTitleId} render={<Card.Title />}>
            {React.string("What should the agent work on?")}
          </Questionnaire.Title>
          <Questionnaire.Description render={<Card.Description />}>
            {React.string("Choose the task that should be handled next.")}
          </Questionnaire.Description>
          <Card.Action>
            <Questionnaire.Progress />
          </Card.Action>
        </Card.Header>
        <Card.Content>
          <Questionnaire.Choices>
            <Questionnaire.Choice value="fix">
              {React.string("Fix the failing tests")}
            </Questionnaire.Choice>
            <Questionnaire.Choice value="refactor">
              {React.string("Refactor the data layer")}
            </Questionnaire.Choice>
            <Questionnaire.Choice value="docs">
              {React.string("Update the integration guide")}
            </Questionnaire.Choice>
          </Questionnaire.Choices>
          <Questionnaire.Error />
        </Card.Content>
      </Questionnaire.Item>
      <Questionnaire.Item ariaLabelledby={outputTitleId} name="output" required=true>
        <Card.Header>
          <Questionnaire.Title id={outputTitleId} render={<Card.Title />}>
            {React.string("What should the final handoff include?")}
          </Questionnaire.Title>
          <Questionnaire.Description render={<Card.Description />}>
            {React.string("Pick the level of detail needed for review.")}
          </Questionnaire.Description>
          <Card.Action>
            <Questionnaire.Progress />
          </Card.Action>
        </Card.Header>
        <Card.Content>
          <Questionnaire.Choices>
            <Questionnaire.Choice value="summary">
              {React.string("Summary only")}
            </Questionnaire.Choice>
            <Questionnaire.Choice value="files">
              {React.string("Summary and changed files")}
            </Questionnaire.Choice>
            <Questionnaire.Choice value="review">
              {React.string("Full review handoff")}
            </Questionnaire.Choice>
          </Questionnaire.Choices>
          <Questionnaire.Error />
        </Card.Content>
      </Questionnaire.Item>
      <Card.Footer>
        <Questionnaire.Actions className="w-full">
          <Questionnaire.Previous />
          <Questionnaire.Next> {React.string("Next")} </Questionnaire.Next>
          <Questionnaire.Submit> {React.string("Create task")} </Questionnaire.Submit>
        </Questionnaire.Actions>
      </Card.Footer>
    </Card>
  </Questionnaire>
}
