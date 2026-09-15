@@directive("'use client'")
@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

type formData
@get external currentForm: JsxEvent.Form.t => Dom.element = "currentTarget"
@new external formData: Dom.element => formData = "FormData"
@send external get: (formData, string) => nullable<string> = "get"
@send external getAll: (formData, string) => array<string> = "getAll"

let items: array<ShadcnReact.Questionnaire.itemDefinition> = [
  {
    choices: [{value: "incremental"}, {value: "module"}, {value: "rewrite"}],
    name: "approach",
    required: true,
  },
]

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let handleSubmit = event => {
    event->JsxEvent.Form.preventDefault
    let data = event->currentForm->formData
    let approachAnswer = data->get("approach")->Nullable.toOption->Option.getOr("None")
    Sonner.toast(
      React.string("Approach selected"),
      ~options={description: React.string(`Approach: ${approachAnswer}`)},
    )
  }
  <Questionnaire
    className="mx-auto max-w-md" items={items} shortcuts=#letters onSubmit={handleSubmit}
  >
    <Questionnaire.Item name="approach" required=true>
      <Questionnaire.Title>
        {React.string("How should the agent approach this refactor?")}
      </Questionnaire.Title>
      <Questionnaire.Description>
        {React.string("Choose a strategy or write a more specific instruction.")}
      </Questionnaire.Description>
      <Questionnaire.Choices>
        <Questionnaire.Choice value="incremental">
          {React.string("Make the smallest safe change")}
        </Questionnaire.Choice>
        <Questionnaire.Choice value="module">
          {React.string("Refactor one module at a time")}
        </Questionnaire.Choice>
        <Questionnaire.Choice value="rewrite">
          {React.string("Replace the implementation completely")}
        </Questionnaire.Choice>
        <Questionnaire.Input
          ariaLabel="Another refactoring approach" placeholder="Describe another approach…"
        />
      </Questionnaire.Choices>
      <Questionnaire.Error />
    </Questionnaire.Item>
    <Questionnaire.Actions>
      <Questionnaire.Submit> {React.string("Use this approach")} </Questionnaire.Submit>
    </Questionnaire.Actions>
  </Questionnaire>
}
