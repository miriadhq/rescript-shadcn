@@directive("'use client'")
@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

type formData
@get external currentForm: JsxEvent.Form.t => Dom.element = "currentTarget"
@new external formData: Dom.element => formData = "FormData"
@send external get: (formData, string) => nullable<string> = "get"
@send external getAll: (formData, string) => array<string> = "getAll"

let items: array<ShadcnReact.Questionnaire.itemDefinition> = [
  {name: "scope", required: true},
  {name: "checks", required: true},
  {name: "output", required: true},
]

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (item, setItem) = React.useState(() => "scope")
  let handleSubmit = event => {
    event->JsxEvent.Form.preventDefault
    let data = event->currentForm->formData
    let scopeAnswer = data->get("scope")->Nullable.toOption->Option.getOr("None")
    let checksAnswer = data->get("checks")->Nullable.toOption->Option.getOr("None")
    let outputAnswer = data->get("output")->Nullable.toOption->Option.getOr("None")
    Sonner.toast(
      React.string("Agent workflow configured"),
      ~options={
        description: React.string(
          `Scope: ${scopeAnswer} · Verification: ${checksAnswer} · Output: ${outputAnswer}`,
        ),
      },
    )
  }
  <div className="relative mx-auto flex h-full w-full max-w-md flex-col">
    <p className="absolute end-0 top-0 text-sm text-muted-foreground" role="status">
      {React.string("Current checkpoint: ")}
      {React.string(
        switch item {
        | "scope" => "Change scope"
        | "checks" => "Verification"
        | _ => "Final output"
        },
      )}
    </p>
    <Questionnaire
      className="mt-auto"
      item={item}
      items={items}
      onItemChange={value => setItem(_ => value)}
      onSubmit={handleSubmit}
    >
      <Questionnaire.Progress />
      <Questionnaire.Item name="scope" required=true>
        <Questionnaire.Title> {React.string("What may the agent change?")} </Questionnaire.Title>
        <Questionnaire.Description>
          {React.string("The host stores the active checkpoint while Questionnaire navigates.")}
        </Questionnaire.Description>
        <Questionnaire.Choices>
          <Questionnaire.Choice value="component">
            {React.string("Only the target component")}
          </Questionnaire.Choice>
          <Questionnaire.Choice value="tests">
            {React.string("Component and related tests")}
          </Questionnaire.Choice>
          <Questionnaire.Choice value="feature">
            {React.string("The complete feature area")}
          </Questionnaire.Choice>
        </Questionnaire.Choices>
        <Questionnaire.Error />
      </Questionnaire.Item>
      <Questionnaire.Item name="checks" required=true>
        <Questionnaire.Title>
          {React.string("Which verification level should it use?")}
        </Questionnaire.Title>
        <Questionnaire.Choices>
          <Questionnaire.Choice value="targeted">
            {React.string("Targeted tests")}
          </Questionnaire.Choice>
          <Questionnaire.Choice value="package">
            {React.string("Package tests and typecheck")}
          </Questionnaire.Choice>
          <Questionnaire.Choice value="full">
            {React.string("Full workspace verification")}
          </Questionnaire.Choice>
        </Questionnaire.Choices>
        <Questionnaire.Error />
      </Questionnaire.Item>
      <Questionnaire.Item name="output" required=true>
        <Questionnaire.Title>
          {React.string("What should the agent return when finished?")}
        </Questionnaire.Title>
        <Questionnaire.Choices>
          <Questionnaire.Choice value="summary">
            {React.string("Concise summary")}
          </Questionnaire.Choice>
          <Questionnaire.Choice value="diff">
            {React.string("Summary with changed files")}
          </Questionnaire.Choice>
          <Questionnaire.Choice value="handoff">
            {React.string("Detailed implementation handoff")}
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
  </div>
}
