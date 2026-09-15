@@directive("'use client'")
@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

type formData
@get external currentForm: JsxEvent.Form.t => Dom.element = "currentTarget"
@new external formData: Dom.element => formData = "FormData"
@send external get: (formData, string) => nullable<string> = "get"
@send external getAll: (formData, string) => array<string> = "getAll"

let items: array<ShadcnReact.Questionnaire.itemDefinition> = [
  {name: "task", required: true},
  {name: "constraints"},
  {name: "review", required: true},
]

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (constraintStatus, setConstraintStatus) = React.useState(() => #unanswered)
  let handleSubmit = event => {
    event->JsxEvent.Form.preventDefault
    let data = event->currentForm->formData
    let taskAnswer = data->get("task")->Nullable.toOption->Option.getOr("None")
    let constraintsAnswer =
      constraintStatus == #skipped
        ? "Skipped"
        : data->get("constraints")->Nullable.toOption->Option.getOr("None")
    let reviewAnswer = data->get("review")->Nullable.toOption->Option.getOr("None")
    Sonner.toast(
      React.string("Agent brief submitted"),
      ~options={
        description: React.string(
          `Task: ${taskAnswer} · Constraints: ${constraintsAnswer} · Review: ${reviewAnswer}`,
        ),
      },
    )
  }
  <Questionnaire
    className="mx-auto max-w-md" defaultItem="task" items={items} onSubmit={handleSubmit}
  >
    <Questionnaire.Progress />
    <Questionnaire.Item name="task" required=true>
      <Questionnaire.Title> {React.string("What kind of change is this?")} </Questionnaire.Title>
      <Questionnaire.Description>
        {React.string("Choose the category that best describes the work.")}
      </Questionnaire.Description>
      <Questionnaire.Choices>
        <Questionnaire.Choice value="feature"> {React.string("New feature")} </Questionnaire.Choice>
        <Questionnaire.Choice value="fix"> {React.string("Bug fix")} </Questionnaire.Choice>
        <Questionnaire.Choice value="refactor"> {React.string("Refactor")} </Questionnaire.Choice>
      </Questionnaire.Choices>
      <Questionnaire.Error />
    </Questionnaire.Item>
    <Questionnaire.Item
      name="constraints" onStatusChange={value => setConstraintStatus(_ => value)}
    >
      <Questionnaire.Title>
        {React.string("Are there any implementation constraints?")}
      </Questionnaire.Title>
      <Questionnaire.Description>
        {React.string("Answer if needed, or intentionally skip this question.")}
      </Questionnaire.Description>
      <Questionnaire.Choices>
        <Questionnaire.Choice value="no-dependencies">
          {React.string("Do not add dependencies")}
        </Questionnaire.Choice>
        <Questionnaire.Choice value="no-migrations">
          {React.string("Do not change the database")}
        </Questionnaire.Choice>
        <Questionnaire.Choice value="preserve-api">
          {React.string("Preserve the public API")}
        </Questionnaire.Choice>
        <Questionnaire.Input
          ariaLabel="Another implementation constraint" placeholder="Describe another constraint…"
        />
      </Questionnaire.Choices>
    </Questionnaire.Item>
    <Questionnaire.Item name="review" required=true>
      <Questionnaire.Title>
        {React.string("How should the work be reviewed?")}
      </Questionnaire.Title>
      <Questionnaire.Description>
        {React.string("Choose the checks the agent should complete before handoff.")}
      </Questionnaire.Description>
      <Questionnaire.Choices>
        <Questionnaire.Choice value="tests">
          {React.string("Run the test suite")}
        </Questionnaire.Choice>
        <Questionnaire.Choice value="diff">
          {React.string("Review the final diff")}
        </Questionnaire.Choice>
        <Questionnaire.Choice value="both">
          {React.string("Tests and diff review")}
        </Questionnaire.Choice>
      </Questionnaire.Choices>
      <Questionnaire.Error />
    </Questionnaire.Item>
    <Questionnaire.Actions>
      <Questionnaire.Previous />
      <Questionnaire.Skip />
      <Questionnaire.Next> {React.string("Next")} </Questionnaire.Next>
      <Questionnaire.Submit> {React.string("Submit brief")} </Questionnaire.Submit>
    </Questionnaire.Actions>
  </Questionnaire>
}
