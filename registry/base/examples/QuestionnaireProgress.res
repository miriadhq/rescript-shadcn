@@directive("'use client'")
@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

type formData
@get external currentForm: JsxEvent.Form.t => Dom.element = "currentTarget"
@new external formData: Dom.element => formData = "FormData"
@send external get: (formData, string) => nullable<string> = "get"
@send external getAll: (formData, string) => array<string> = "getAll"

let items: array<ShadcnReact.Questionnaire.itemDefinition> = [
  {name: "scope", required: true},
  {name: "strategy", required: true},
  {name: "tests", required: true},
  {name: "delivery", required: true},
]

@module("react")
external renderDiv: (
  @as("div") _,
  ShadcnReact.Questionnaire.domProps,
  React.element,
) => React.element = "createElement"

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let renderProgress = (
    props: ShadcnReact.Questionnaire.domProps,
    state: ShadcnReact.Questionnaire.rootState,
  ) =>
    renderDiv(
      props,
      <>
        <div className="mb-2 flex gap-1.5" ariaHidden=true>
          {Array.fromInitializer(~length=state.total, index =>
            <span
              key={Int.toString(index)}
              className={index < state.current
                ? "h-1.5 flex-1 rounded-full bg-primary"
                : "h-1.5 flex-1 rounded-full bg-muted"}
            />
          )->React.array}
        </div>
        <span>
          {React.string("Checkpoint ")} {React.int(state.current)} {React.string(" of ")} {React.int(state.total)}
        </span>
      </>,
    )
  let handleSubmit = event => {
    event->JsxEvent.Form.preventDefault
    let data = event->currentForm->formData
    let scopeAnswer = data->get("scope")->Nullable.toOption->Option.getOr("None")
    let strategyAnswer = data->get("strategy")->Nullable.toOption->Option.getOr("None")
    let testsAnswer = data->get("tests")->Nullable.toOption->Option.getOr("None")
    let deliveryAnswer = data->get("delivery")->Nullable.toOption->Option.getOr("None")
    Sonner.toast(
      React.string("Pull request plan ready"),
      ~options={
        description: React.string(
          `Scope: ${scopeAnswer} · Commits: ${strategyAnswer} · Tests: ${testsAnswer} · Delivery: ${deliveryAnswer}`,
        ),
      },
    )
  }
  <Questionnaire
    className="mx-auto max-w-md" defaultItem="scope" items={items} onSubmit={handleSubmit}
  >
    <Questionnaire.Progress.WithRender className="w-full" render={renderProgress} />
    <Questionnaire.Item name="scope" required=true>
      <Questionnaire.Title> {React.string("How large is the change?")} </Questionnaire.Title>
      <Questionnaire.Choices>
        <Questionnaire.Choice value="small"> {React.string("Small patch")} </Questionnaire.Choice>
        <Questionnaire.Choice value="medium">
          {React.string("Feature-sized change")}
        </Questionnaire.Choice>
        <Questionnaire.Choice value="large">
          {React.string("Cross-package change")}
        </Questionnaire.Choice>
      </Questionnaire.Choices>
      <Questionnaire.Error />
    </Questionnaire.Item>
    <Questionnaire.Item name="strategy" required=true>
      <Questionnaire.Title>
        {React.string("How should commits be organized?")}
      </Questionnaire.Title>
      <Questionnaire.Choices>
        <Questionnaire.Choice value="single">
          {React.string("Single commit")}
        </Questionnaire.Choice>
        <Questionnaire.Choice value="logical">
          {React.string("Logical commits")}
        </Questionnaire.Choice>
        <Questionnaire.Choice value="squash">
          {React.string("Squash before review")}
        </Questionnaire.Choice>
      </Questionnaire.Choices>
      <Questionnaire.Error />
    </Questionnaire.Item>
    <Questionnaire.Item name="tests" required=true>
      <Questionnaire.Title> {React.string("Which tests should run?")} </Questionnaire.Title>
      <Questionnaire.Choices>
        <Questionnaire.Choice value="targeted">
          {React.string("Targeted tests")}
        </Questionnaire.Choice>
        <Questionnaire.Choice value="package">
          {React.string("Package suite")}
        </Questionnaire.Choice>
        <Questionnaire.Choice value="workspace">
          {React.string("Full workspace")}
        </Questionnaire.Choice>
      </Questionnaire.Choices>
      <Questionnaire.Error />
    </Questionnaire.Item>
    <Questionnaire.Item name="delivery" required=true>
      <Questionnaire.Title>
        {React.string("How should the work be delivered?")}
      </Questionnaire.Title>
      <Questionnaire.Choices>
        <Questionnaire.Choice value="patch"> {React.string("Patch only")} </Questionnaire.Choice>
        <Questionnaire.Choice value="commit">
          {React.string("Committed locally")}
        </Questionnaire.Choice>
        <Questionnaire.Choice value="branch">
          {React.string("Push a review branch")}
        </Questionnaire.Choice>
      </Questionnaire.Choices>
      <Questionnaire.Error />
    </Questionnaire.Item>
    <Questionnaire.Actions>
      <Questionnaire.Previous />
      <Questionnaire.Next> {React.string("Next")} </Questionnaire.Next>
      <Questionnaire.Submit> {React.string("Finish plan")} </Questionnaire.Submit>
    </Questionnaire.Actions>
  </Questionnaire>
}
