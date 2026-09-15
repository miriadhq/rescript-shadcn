@@directive("'use client'")
@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

type formData
@get external currentForm: JsxEvent.Form.t => Dom.element = "currentTarget"
@new external formData: Dom.element => formData = "FormData"
@send external get: (formData, string) => nullable<string> = "get"
@send external getAll: (formData, string) => array<string> = "getAll"

let items: array<ShadcnReact.Questionnaire.itemDefinition> = [
  {name: "task", required: true},
  {name: "review", required: true},
  {name: "delivery", required: true},
]

let itemClassName = "data-active:animate-in data-active:fade-in-0 data-active:slide-in-from-bottom-2 data-active:duration-300 motion-reduce:animate-none"

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let handleSubmit = event => {
    event->JsxEvent.Form.preventDefault
    let data = event->currentForm->formData
    let taskAnswer = data->get("task")->Nullable.toOption->Option.getOr("None")
    let reviewAnswer = data->get("review")->Nullable.toOption->Option.getOr("None")
    let deliveryAnswer = data->get("delivery")->Nullable.toOption->Option.getOr("None")
    Sonner.toast(
      React.string("Agent workflow saved"),
      ~options={
        description: React.string(
          `Task: ${taskAnswer} · Review: ${reviewAnswer} · Delivery: ${deliveryAnswer}`,
        ),
      },
    )
  }
  <Questionnaire
    className="mx-auto max-w-md" defaultItem="task" items={items} onSubmit={handleSubmit}
  >
    <Questionnaire.Progress />
    <Questionnaire.Item className={itemClassName} name="task" required=true>
      <Questionnaire.Title> {React.string("What should the agent do?")} </Questionnaire.Title>
      <Questionnaire.Description>
        {React.string("Choose the task for this run.")}
      </Questionnaire.Description>
      <Questionnaire.Choices>
        <Questionnaire.Choice value="implement">
          {React.string("Implement the requested change")}
        </Questionnaire.Choice>
        <Questionnaire.Choice value="debug">
          {React.string("Debug the current behavior")}
        </Questionnaire.Choice>
        <Questionnaire.Choice value="review">
          {React.string("Review the implementation")}
        </Questionnaire.Choice>
      </Questionnaire.Choices>
      <Questionnaire.Error />
    </Questionnaire.Item>
    <Questionnaire.Item className={itemClassName} name="review" required=true>
      <Questionnaire.Title>
        {React.string("How should the work be reviewed?")}
      </Questionnaire.Title>
      <Questionnaire.Description>
        {React.string("Select the verification depth.")}
      </Questionnaire.Description>
      <Questionnaire.Choices>
        <Questionnaire.Choice value="targeted">
          {React.string("Targeted checks")}
        </Questionnaire.Choice>
        <Questionnaire.Choice value="complete">
          {React.string("Complete test suite")}
        </Questionnaire.Choice>
        <Questionnaire.Choice value="manual">
          {React.string("Tests and manual QA")}
        </Questionnaire.Choice>
      </Questionnaire.Choices>
      <Questionnaire.Error />
    </Questionnaire.Item>
    <Questionnaire.Item className={itemClassName} name="delivery" required=true>
      <Questionnaire.Title>
        {React.string("How should the result be delivered?")}
      </Questionnaire.Title>
      <Questionnaire.Description>
        {React.string("Choose the final handoff format.")}
      </Questionnaire.Description>
      <Questionnaire.Choices>
        <Questionnaire.Choice value="summary">
          {React.string("Concise summary")}
        </Questionnaire.Choice>
        <Questionnaire.Choice value="diff">
          {React.string("Summary and changed files")}
        </Questionnaire.Choice>
        <Questionnaire.Choice value="handoff">
          {React.string("Detailed review handoff")}
        </Questionnaire.Choice>
      </Questionnaire.Choices>
      <Questionnaire.Error />
    </Questionnaire.Item>
    <Questionnaire.Actions>
      <Questionnaire.Previous />
      <Questionnaire.Next> {React.string("Next")} </Questionnaire.Next>
      <Questionnaire.Submit> {React.string("Save workflow")} </Questionnaire.Submit>
    </Questionnaire.Actions>
  </Questionnaire>
}
