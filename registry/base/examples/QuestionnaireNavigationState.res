@@directive("'use client'")
@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

type formData
@get external currentForm: JsxEvent.Form.t => Dom.element = "currentTarget"
@new external formData: Dom.element => formData = "FormData"
@send external get: (formData, string) => nullable<string> = "get"
@send external getAll: (formData, string) => array<string> = "getAll"

let items: array<ShadcnReact.Questionnaire.itemDefinition> = [
  {name: "permission", required: true},
  {name: "verification", required: true},
]

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (item, setItem) = React.useState(() => "permission")
  let (statuses, setStatuses) = React.useState((): dict<ShadcnReact.Questionnaire.status> =>
    dict{"permission": #unanswered, "verification": #unanswered}
  )
  let unanswered = statuses->Dict.get(item) == Some(#unanswered)
  let setStatus = (name, status) =>
    setStatuses(current => {
      let next = current->Dict.copy
      next->Dict.set(name, status)
      next
    })
  let handleSubmit = event => {
    event->JsxEvent.Form.preventDefault
    let data = event->currentForm->formData
    let permissionAnswer = data->get("permission")->Nullable.toOption->Option.getOr("None")
    let verificationAnswer = data->get("verification")->Nullable.toOption->Option.getOr("None")
    Sonner.toast(
      React.string("Permissions saved"),
      ~options={
        description: React.string(
          `Permission: ${permissionAnswer} · Verification: ${verificationAnswer}`,
        ),
      },
    )
  }
  <Questionnaire
    className="mx-auto max-w-md"
    item={item}
    items={items}
    onItemChange={_nextItem => setItem(_ => _nextItem)}
    onSubmit={handleSubmit}
  >
    <Questionnaire.Progress />
    <Questionnaire.Item
      name="permission" required=true onStatusChange={status => setStatus("permission", status)}
    >
      <Questionnaire.Title> {React.string("What may the agent modify?")} </Questionnaire.Title>
      <Questionnaire.Description>
        {React.string("Next is intentionally disabled until an answer is selected.")}
      </Questionnaire.Description>
      <Questionnaire.Choices>
        <Questionnaire.Choice value="files"> {React.string("Project files")} </Questionnaire.Choice>
        <Questionnaire.Choice value="tests">
          {React.string("Project files and tests")}
        </Questionnaire.Choice>
        <Questionnaire.Choice value="config">
          {React.string("Files, tests, and configuration")}
        </Questionnaire.Choice>
      </Questionnaire.Choices>
      <Questionnaire.Error />
    </Questionnaire.Item>
    <Questionnaire.Item
      name="verification" required=true onStatusChange={status => setStatus("verification", status)}
    >
      <Questionnaire.Title>
        {React.string("What must pass before completion?")}
      </Questionnaire.Title>
      <Questionnaire.Choices>
        <Questionnaire.Choice value="tests"> {React.string("Tests")} </Questionnaire.Choice>
        <Questionnaire.Choice value="types">
          {React.string("Tests and types")}
        </Questionnaire.Choice>
        <Questionnaire.Choice value="all">
          {React.string("Tests, types, and visual QA")}
        </Questionnaire.Choice>
      </Questionnaire.Choices>
      <Questionnaire.Error />
    </Questionnaire.Item>
    <Questionnaire.Actions>
      <Questionnaire.Previous />
      <Questionnaire.Next
        className="data-[status=unanswered]:opacity-50" disabled={unanswered} variant=Secondary
      >
        {React.string("Next")}
      </Questionnaire.Next>
      <Questionnaire.Submit disabled={unanswered}>
        {React.string("Save permissions")}
      </Questionnaire.Submit>
    </Questionnaire.Actions>
  </Questionnaire>
}
