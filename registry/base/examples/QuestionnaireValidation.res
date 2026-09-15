@@directive("'use client'")
@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

type formData
@get external currentForm: JsxEvent.Form.t => Dom.element = "currentTarget"
@new external formData: Dom.element => formData = "FormData"
@send external get: (formData, string) => nullable<string> = "get"
@send external getAll: (formData, string) => array<string> = "getAll"

let items: array<ShadcnReact.Questionnaire.itemDefinition> = [
  {name: "detail", required: true},
  {name: "audience", required: true},
]

@module("react")
external renderDiv: (
  @as("div") _,
  ShadcnReact.Questionnaire.domProps,
  React.element,
) => React.element = "createElement"

module ValidationProgress = {
  @react.component
  let make = () =>
    <Questionnaire.Progress.WithRender
      className="min-w-0"
      render={(props, state) =>
        renderDiv(
          props,
          React.array([React.int(state.current), React.string(" / "), React.int(state.total)]),
        )}
    />
}

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (item, setItem) = React.useState(() => "detail")
  let (errors, setErrors) = React.useState(() => dict{})
  let clearError = name =>
    setErrors(current => {
      let next = current->Dict.copy
      next->Dict.delete(name)
      next
    })
  let handleSubmit = event => {
    event->JsxEvent.Form.preventDefault
    let data = event->currentForm->formData
    let detail = data->get("detail")->Nullable.toOption->Option.getOr("")
    let audience = data->get("audience")->Nullable.toOption->Option.getOr("")
    let nextErrors = dict{}
    if detail != "summary" && detail != "complete" {
      nextErrors->Dict.set("detail", "Select an answer.")
    }
    if audience != "team" && audience != "public" {
      nextErrors->Dict.set("audience", "Select an audience.")
    }
    if audience == "public" && detail == "summary" {
      nextErrors->Dict.set(
        "detail",
        "Public answers need enough context. Choose a complete answer.",
      )
    }
    setErrors(_ => nextErrors)
    if nextErrors->Dict.has("detail") {
      setItem(_ => "detail")
    } else if nextErrors->Dict.has("audience") {
      setItem(_ => "audience")
    } else {
      Sonner.toast(
        React.string("Agent response configured"),
        ~options={description: React.string(`Detail: ${detail} · Audience: ${audience}`)},
      )
    }
  }
  <Questionnaire
    className="mx-auto max-w-md"
    item={item}
    items={items}
    onItemChange={value => setItem(_ => value)}
    onSubmit={handleSubmit}
  >
    <Card className="w-full">
      <Questionnaire.Item invalid={errors->Dict.has("detail")} name="detail" required=true>
        <Card.Header>
          <Questionnaire.Title>
            {React.string("How much detail should the answer include?")}
          </Questionnaire.Title>
          <Questionnaire.Description>
            {React.string("Choose the response depth.")}
          </Questionnaire.Description>
          <Card.Action>
            <ValidationProgress />
          </Card.Action>
        </Card.Header>
        <Card.Content>
          <Questionnaire.Choices>
            <Questionnaire.Choice value="summary" onChange={_ => clearError("detail")}>
              {React.string("Concise summary")}
            </Questionnaire.Choice>
            <Questionnaire.Choice value="complete" onChange={_ => clearError("detail")}>
              {React.string("Complete answer")}
            </Questionnaire.Choice>
          </Questionnaire.Choices>
          <Questionnaire.Error>
            {errors->Dict.get("detail")->Option.map(React.string)->Option.getOr(React.null)}
          </Questionnaire.Error>
        </Card.Content>
      </Questionnaire.Item>
      <Questionnaire.Item invalid={errors->Dict.has("audience")} name="audience" required=true>
        <Card.Header>
          <Questionnaire.Title> {React.string("Who will read the answer?")} </Questionnaire.Title>
          <Questionnaire.Description>
            {React.string("Public answers require complete context.")}
          </Questionnaire.Description>
          <Card.Action>
            <ValidationProgress />
          </Card.Action>
        </Card.Header>
        <Card.Content>
          <Questionnaire.Choices>
            <Questionnaire.Choice value="team" onChange={_ => clearError("audience")}>
              {React.string("My team")}
            </Questionnaire.Choice>
            <Questionnaire.Choice value="public" onChange={_ => clearError("audience")}>
              {React.string("Public audience")}
            </Questionnaire.Choice>
          </Questionnaire.Choices>
          <Questionnaire.Error>
            {errors->Dict.get("audience")->Option.map(React.string)->Option.getOr(React.null)}
          </Questionnaire.Error>
        </Card.Content>
      </Questionnaire.Item>
      <Card.Footer>
        <Questionnaire.Actions>
          <Questionnaire.Previous />
          <Questionnaire.Next> {React.string("Next")} </Questionnaire.Next>
          <Questionnaire.Submit> {React.string("Validate answers")} </Questionnaire.Submit>
        </Questionnaire.Actions>
      </Card.Footer>
    </Card>
  </Questionnaire>
}
