@@directive("'use client'")
@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

type formData
@get external currentForm: JsxEvent.Form.t => Dom.element = "currentTarget"
@new external formData: Dom.element => formData = "FormData"
@send external get: (formData, string) => nullable<string> = "get"
@send external getAll: (formData, string) => array<string> = "getAll"

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (runtime, setRuntime) = React.useState(() => "local")
  let items: array<ShadcnReact.Questionnaire.itemDefinition> = [
    {name: "runtime", required: true},
    {name: "environment", disabled: runtime != "cloud", required: true},
    {name: "approval", required: true},
  ]
  let handleSubmit = event => {
    event->JsxEvent.Form.preventDefault
    let data = event->currentForm->formData
    let runtimeAnswer = data->get("runtime")->Nullable.toOption->Option.getOr("None")
    let environmentAnswer =
      data->get("environment")->Nullable.toOption->Option.getOr("Not applicable")
    let approvalAnswer = data->get("approval")->Nullable.toOption->Option.getOr("None")
    Sonner.toast(
      React.string("Execution plan saved"),
      ~options={
        description: React.string(
          `Runtime: ${runtimeAnswer} · Environment: ${environmentAnswer} · Approval: ${approvalAnswer}`,
        ),
      },
    )
  }
  <Questionnaire
    className="mx-auto max-w-md" defaultItem="runtime" items={items} onSubmit={handleSubmit}
  >
    <Questionnaire.Progress />
    <Questionnaire.Item name="runtime" required=true>
      <Questionnaire.Title> {React.string("Where should the agent run?")} </Questionnaire.Title>
      <Questionnaire.Description>
        {React.string("Cloud runs add an environment question to this flow.")}
      </Questionnaire.Description>
      <Questionnaire.Choices>
        <Questionnaire.Choice
          checked={runtime == "local"} value="local" onChange={_ => setRuntime(_ => "local")}
        >
          {React.string("Local workspace")}
        </Questionnaire.Choice>
        <Questionnaire.Choice
          checked={runtime == "cloud"} value="cloud" onChange={_ => setRuntime(_ => "cloud")}
        >
          {React.string("Cloud workspace")}
        </Questionnaire.Choice>
      </Questionnaire.Choices>
      <Questionnaire.Error />
    </Questionnaire.Item>
    <Questionnaire.Item disabled={runtime != "cloud"} name="environment" required=true>
      <Questionnaire.Title>
        {React.string("Which cloud environment should it use?")}
      </Questionnaire.Title>
      <Questionnaire.Choices>
        <Questionnaire.Choice value="preview"> {React.string("Preview")} </Questionnaire.Choice>
        <Questionnaire.Choice value="staging"> {React.string("Staging")} </Questionnaire.Choice>
        <Questionnaire.Choice value="isolated">
          {React.string("Isolated sandbox")}
        </Questionnaire.Choice>
      </Questionnaire.Choices>
      <Questionnaire.Error />
    </Questionnaire.Item>
    <Questionnaire.Item name="approval" required=true>
      <Questionnaire.Title>
        {React.string("When should the agent request approval?")}
      </Questionnaire.Title>
      <Questionnaire.Choices>
        <Questionnaire.Choice value="writes">
          {React.string("Before writing files")}
        </Questionnaire.Choice>
        <Questionnaire.Choice value="commands">
          {React.string("Before running commands")}
        </Questionnaire.Choice>
        <Questionnaire.Choice value="sensitive">
          {React.string("Only for sensitive actions")}
        </Questionnaire.Choice>
      </Questionnaire.Choices>
      <Questionnaire.Error />
    </Questionnaire.Item>
    <Questionnaire.Actions>
      <Questionnaire.Previous />
      <Questionnaire.Next> {React.string("Next")} </Questionnaire.Next>
      <Questionnaire.Submit> {React.string("Save execution plan")} </Questionnaire.Submit>
    </Questionnaire.Actions>
  </Questionnaire>
}
