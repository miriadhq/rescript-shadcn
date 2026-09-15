@@directive("'use client'")
@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

type formData
@get external currentForm: JsxEvent.Form.t => Dom.element = "currentTarget"
@new external formData: Dom.element => formData = "FormData"
@send external get: (formData, string) => nullable<string> = "get"
@send external getAll: (formData, string) => array<string> = "getAll"

let items: array<ShadcnReact.Questionnaire.itemDefinition> = [
  {
    choices: [{value: "inspect"}, {value: "tests"}, {value: "patch"}],
    name: "action",
    required: true,
  },
]

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (shortcuts, setShortcuts) = React.useState(() => Some(
    (#letters: ShadcnReact.Questionnaire.shortcuts),
  ))
  let handleSubmit = event => {
    event->JsxEvent.Form.preventDefault
    let data = event->currentForm->formData
    let actionAnswer = data->get("action")->Nullable.toOption->Option.getOr("None")
    let shortcutsAnswer = shortcuts->Option.map(value => (value :> string))->Option.getOr("none")
    Sonner.toast(
      React.string("Next action selected"),
      ~options={
        description: React.string(`Action: ${actionAnswer} · Shortcuts: ${shortcutsAnswer}`),
      },
    )
  }
  <div className="relative mx-auto flex h-full w-full max-w-md flex-col">
    <NativeSelect
      ariaLabel="Shortcut style"
      className="absolute end-0 top-0"
      value={shortcuts->Option.map(value => (value :> string))->Option.getOr("none")}
      onChange={event => {
        let value = (event->JsxEvent.Form.target)["value"]
        setShortcuts(_ =>
          switch value {
          | "letters" => Some(#letters)
          | "numbers" => Some(#numbers)
          | _ => None
          }
        )
      }}
    >
      <NativeSelect.Option value="none"> {React.string("No shortcuts")} </NativeSelect.Option>
      <NativeSelect.Option value="letters"> {React.string("Letters")} </NativeSelect.Option>
      <NativeSelect.Option value="numbers"> {React.string("Numbers")} </NativeSelect.Option>
    </NativeSelect>
    <Questionnaire className="mt-auto" items={items} ?shortcuts onSubmit={handleSubmit}>
      <Questionnaire.Item name="action" required=true>
        <Questionnaire.Title>
          {React.string("What should the agent do next?")}
        </Questionnaire.Title>
        <Questionnaire.Description>
          {React.string("Use the displayed shortcut or navigate with the keyboard.")}
        </Questionnaire.Description>
        <Questionnaire.Choices>
          <Questionnaire.Choice value="inspect">
            {React.string("Inspect the implementation")}
          </Questionnaire.Choice>
          <Questionnaire.Choice value="tests">
            {React.string("Run the relevant tests")}
          </Questionnaire.Choice>
          <Questionnaire.Choice value="patch">
            {React.string("Prepare the patch")}
          </Questionnaire.Choice>
        </Questionnaire.Choices>
        <Questionnaire.Error />
      </Questionnaire.Item>
      <Questionnaire.Actions>
        <Questionnaire.Submit> {React.string("Confirm action")} </Questionnaire.Submit>
      </Questionnaire.Actions>
    </Questionnaire>
  </div>
}
