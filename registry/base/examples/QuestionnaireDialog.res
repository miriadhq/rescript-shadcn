@@directive("'use client'")
@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

type formData
@get external currentForm: JsxEvent.Form.t => Dom.element = "currentTarget"
@new external formData: Dom.element => formData = "FormData"
@send external get: (formData, string) => nullable<string> = "get"
@send external getAll: (formData, string) => array<string> = "getAll"

let items: array<ShadcnReact.Questionnaire.itemDefinition> = [
  {name: "scope", required: true},
  {name: "tests", required: true},
]

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (open_, setOpen) = React.useState(() => false)
  let handleSubmit = event => {
    event->JsxEvent.Form.preventDefault
    let data = event->currentForm->formData
    setOpen(_ => false)
    let scopeAnswer = data->get("scope")->Nullable.toOption->Option.getOr("None")
    let testsAnswer = data->get("tests")->Nullable.toOption->Option.getOr("None")
    Sonner.toast(
      React.string("Clarification sent"),
      ~options={description: React.string(`Scope: ${scopeAnswer} · Verification: ${testsAnswer}`)},
    )
  }
  <Dialog open_={open_} onOpenChange={(value, _) => setOpen(_ => value)}>
    <Dialog.Trigger render={<Button variant=Outline />}>
      {React.string("Open clarification")}
    </Dialog.Trigger>
    <Dialog.Content>
      <Questionnaire defaultItem="scope" items={items} onSubmit={handleSubmit}>
        <Questionnaire.Item name="scope" required=true>
          <Dialog.Header>
            <Questionnaire.Progress />
            <Questionnaire.Title render={<Dialog.Title />}>
              {React.string("Which files are in scope?")}
            </Questionnaire.Title>
            <Questionnaire.Description render={<Dialog.Description />}>
              {React.string("Choose how broadly the agent can update the workspace.")}
            </Questionnaire.Description>
          </Dialog.Header>
          <Questionnaire.Choices>
            <Questionnaire.Choice value="component">
              {React.string("Component only")}
            </Questionnaire.Choice>
            <Questionnaire.Choice value="feature">
              {React.string("Complete feature directory")}
            </Questionnaire.Choice>
            <Questionnaire.Choice value="workspace">
              {React.string("Any related workspace file")}
            </Questionnaire.Choice>
          </Questionnaire.Choices>
          <Questionnaire.Error />
        </Questionnaire.Item>
        <Questionnaire.Item name="tests" required=true>
          <Dialog.Header>
            <Questionnaire.Progress />
            <Questionnaire.Title render={<Dialog.Title />}>
              {React.string("How much verification is needed?")}
            </Questionnaire.Title>
            <Questionnaire.Description render={<Dialog.Description />}>
              {React.string("Choose the checks the agent should run before handoff.")}
            </Questionnaire.Description>
          </Dialog.Header>
          <Questionnaire.Choices>
            <Questionnaire.Choice value="targeted">
              {React.string("Targeted tests")}
            </Questionnaire.Choice>
            <Questionnaire.Choice value="package">
              {React.string("Package tests")}
            </Questionnaire.Choice>
            <Questionnaire.Choice value="full">
              {React.string("Full workspace verification")}
            </Questionnaire.Choice>
          </Questionnaire.Choices>
          <Questionnaire.Error />
        </Questionnaire.Item>
        <Dialog.Footer>
          <Dialog.Close render={<Button type_=Button variant=Outline />}>
            {React.string("Cancel")}
          </Dialog.Close>
          <Questionnaire.Actions>
            <Questionnaire.Previous />
            <Questionnaire.Next> {React.string("Next")} </Questionnaire.Next>
            <Questionnaire.Submit> {React.string("Send answer")} </Questionnaire.Submit>
          </Questionnaire.Actions>
        </Dialog.Footer>
      </Questionnaire>
    </Dialog.Content>
  </Dialog>
}
