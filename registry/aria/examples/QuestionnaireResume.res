@@directive("'use client'")
@@jsxConfig({version: 4, mode: "automatic", module_: "ReactAria.ReactAriaJsxDOM"})

type formData
@get external currentForm: JsxEvent.Form.t => Dom.element = "currentTarget"
@new external formData: Dom.element => formData = "FormData"
@send external get: (formData, string) => nullable<string> = "get"
@send external getAll: (formData, string) => array<string> = "getAll"

let items: array<ShadcnReact.Questionnaire.itemDefinition> = [
  {name: "change", required: true},
  {name: "verification", required: true},
  {name: "notes"},
]

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let handleSubmit = event => {
    event->JsxEvent.Form.preventDefault
    let data = event->currentForm->formData
    let changeAnswer = data->get("change")->Nullable.toOption->Option.getOr("None")
    let verificationAnswer = {
      let values = data->getAll("verification")->Array.join(", ")
      values == "" ? "None" : values
    }
    let notesAnswer = data->get("notes")->Nullable.toOption->Option.getOr("None")
    Sonner.toast(
      React.string("Draft updated"),
      ~options={
        description: React.string(
          `Migration: ${changeAnswer} · Verification: ${verificationAnswer} · Notes: ${notesAnswer}`,
        ),
      },
    )
  }
  <Questionnaire
    className="mx-auto max-w-md"
    defaultItem="verification"
    items={items}
    onReset={_ => Sonner.toast(React.string("Saved answers restored"))}
    onSubmit={handleSubmit}
  >
    <Questionnaire.Progress />
    <Questionnaire.Item name="change" required=true>
      <Questionnaire.Title> {React.string("What kind of migration is this?")} </Questionnaire.Title>
      <Questionnaire.Description>
        {React.string("This answer was saved during the previous session.")}
      </Questionnaire.Description>
      <Questionnaire.Choices>
        <Questionnaire.Choice value="incremental" defaultChecked=true>
          {React.string("Incremental migration")}
        </Questionnaire.Choice>
        <Questionnaire.Choice value="cutover">
          {React.string("Single cutover")}
        </Questionnaire.Choice>
      </Questionnaire.Choices>
      <Questionnaire.Error />
    </Questionnaire.Item>
    <Questionnaire.Item name="verification" multiple=true required=true>
      <Questionnaire.Title>
        {React.string("How should the migration be verified?")}
      </Questionnaire.Title>
      <Questionnaire.Description>
        {React.string("These checks were selected during the previous session.")}
      </Questionnaire.Description>
      <Questionnaire.Choices>
        <Questionnaire.Choice value="tests" defaultChecked=true>
          {React.string("Run migration tests")}
        </Questionnaire.Choice>
        <Questionnaire.Choice value="typecheck" defaultChecked=true>
          {React.string("Run the typecheck")}
        </Questionnaire.Choice>
        <Questionnaire.Choice value="manual">
          {React.string("Perform a manual smoke test")}
        </Questionnaire.Choice>
      </Questionnaire.Choices>
      <Questionnaire.Error />
    </Questionnaire.Item>
    <Questionnaire.Item name="notes">
      <Questionnaire.Title>
        {React.string("Anything else the agent should remember?")}
      </Questionnaire.Title>
      <Questionnaire.Description>
        {React.string("This note was saved with the draft.")}
      </Questionnaire.Description>
      <Questionnaire.Input
        ariaLabel="Saved migration note" defaultValue="Keep the existing public API stable."
      />
    </Questionnaire.Item>
    <Questionnaire.Actions>
      <Button type_="reset" variant=Outline> {React.string("Reset changes")} </Button>
      <Questionnaire.Previous />
      <Questionnaire.Next> {React.string("Next")} </Questionnaire.Next>
      <Questionnaire.Submit> {React.string("Update draft")} </Questionnaire.Submit>
    </Questionnaire.Actions>
  </Questionnaire>
}
