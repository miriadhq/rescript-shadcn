@@directive("'use client'")
@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

type formData
@get external currentForm: JsxEvent.Form.t => Dom.element = "currentTarget"
@new external formData: Dom.element => formData = "FormData"
@send external get: (formData, string) => nullable<string> = "get"
@send external getAll: (formData, string) => array<string> = "getAll"

let items: array<ShadcnReact.Questionnaire.itemDefinition> = [
  {
    choices: [{value: "source"}, {value: "tests"}, {value: "docs"}, {value: "history"}],
    name: "context",
    required: true,
  },
]

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let handleSubmit = event => {
    event->JsxEvent.Form.preventDefault
    let data = event->currentForm->formData
    let contextAnswer = {
      let values = data->getAll("context")->Array.join(", ")
      values == "" ? "None" : values
    }
    Sonner.toast(
      React.string("Context selected"),
      ~options={description: React.string(`Context: ${contextAnswer}`)},
    )
  }
  <Questionnaire
    className="mx-auto max-w-md" items={items} shortcuts=#letters onSubmit={handleSubmit}
  >
    <Questionnaire.Item name="context" multiple=true required=true>
      <Questionnaire.Title>
        {React.string("What context should the agent inspect?")}
      </Questionnaire.Title>
      <Questionnaire.Description>
        {React.string("Select every source that may affect the implementation.")}
      </Questionnaire.Description>
      <Questionnaire.Choices>
        <Questionnaire.Choice value="source">
          {React.string("Relevant source files")}
        </Questionnaire.Choice>
        <Questionnaire.Choice value="tests">
          {React.string("Existing tests")}
        </Questionnaire.Choice>
        <Questionnaire.Choice value="docs">
          {React.string("Architecture documentation")}
        </Questionnaire.Choice>
        <Questionnaire.Choice value="history">
          {React.string("Recent commit history")}
        </Questionnaire.Choice>
      </Questionnaire.Choices>
      <Questionnaire.Error />
    </Questionnaire.Item>
    <Questionnaire.Actions>
      <Questionnaire.Submit> {React.string("Share context")} </Questionnaire.Submit>
    </Questionnaire.Actions>
  </Questionnaire>
}
