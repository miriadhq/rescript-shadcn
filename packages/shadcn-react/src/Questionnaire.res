type status = [#unanswered | #answered | #skipped]
type shortcuts = [#letters | #numbers]
type choiceDefinition = {disabled?: bool, value: string}
type itemDefinition = {
  choices?: array<choiceDefinition>,
  disabled?: bool,
  name: string,
  required?: bool,
}
type rootState = {current: int, first: bool, last: bool, total: int}
type navigationState = {
  disabled: bool,
  shortcut: nullable<string>,
  status: nullable<status>,
  visible: bool,
}
type domProps = {
  children?: React.element,
  className?: string,
  id?: string,
  ref?: ReactDOM.domRef,
  style?: ReactDOM.Style.t,
  title?: string,
  hidden?: bool,
  disabled?: bool,
  tabIndex?: int,
  onClick?: JsxEvent.Mouse.t => unit,
  onKeyDown?: JsxEvent.Keyboard.t => unit,
  onChange?: JsxEvent.Form.t => unit,
  onBlur?: JsxEvent.Focus.t => unit,
  onFocus?: JsxEvent.Focus.t => unit,
  @as("data-slot") dataSlot?: string,
  @as("data-size") dataSize?: string,
  @as("data-variant") dataVariant?: string,
  @as("aria-label") ariaLabel?: string,
  @as("aria-labelledby") ariaLabelledby?: string,
  @as("aria-describedby") ariaDescribedby?: string,
  @as("aria-hidden") ariaHidden?: bool,
  @as("aria-invalid") ariaInvalid?: bool,
  role?: string,
}
type elementProps = {...domProps, render?: React.element}
type renderProps<'state> = {...domProps, render: (domProps, 'state) => React.element}

module Root = {
  type props = {
    ...domProps,
    defaultItem?: string,
    item?: string,
    items?: array<itemDefinition>,
    onItemChange?: string => unit,
    shortcuts?: shortcuts,
    onSubmit?: JsxEvent.Form.t => unit,
    onReset?: JsxEvent.Form.t => unit,
    noValidate?: bool,
    action?: string,
    method?: string,
  }
  @module("@shadcn/react/questionnaire") @scope("Questionnaire")
  external make: React.component<props> = "Root"
}

module Progress = {
  type props = {
    ...elementProps,
  }
  @module("@shadcn/react/questionnaire") @scope("Questionnaire")
  external make: React.component<props> = "Progress"
  module WithRender = {
    type props = {...renderProps<rootState>}
    @module("@shadcn/react/questionnaire") @scope("Questionnaire")
    external make: React.component<props> = "Progress"
  }
}

module Item = {
  type props = {
    ...domProps,
    name: string,
    invalid?: bool,
    multiple?: bool,
    onStatusChange?: status => unit,
    required?: bool,
  }
  @module("@shadcn/react/questionnaire") @scope("Questionnaire")
  external make: React.component<props> = "Item"
}

module Title = {
  type props = {
    ...elementProps,
  }
  @module("@shadcn/react/questionnaire") @scope("Questionnaire")
  external make: React.component<props> = "Title"
}

module Description = {
  type props = {
    ...elementProps,
  }
  @module("@shadcn/react/questionnaire") @scope("Questionnaire")
  external make: React.component<props> = "Description"
}

module Choices = {
  type props = {
    ...elementProps,
  }
  @module("@shadcn/react/questionnaire") @scope("Questionnaire")
  external make: React.component<props> = "Choices"
}

module Choice = {
  type props = {
    ...elementProps,
    checked?: bool,
    defaultChecked?: bool,
    value: string,
  }
  @module("@shadcn/react/questionnaire") @scope("Questionnaire")
  external make: React.component<props> = "Choice"
}

module ChoiceInput = {
  type props = {
    ...elementProps,
  }
  @module("@shadcn/react/questionnaire") @scope("Questionnaire")
  external make: React.component<props> = "ChoiceInput"
}

module ChoiceLabel = {
  type props = {
    ...elementProps,
  }
  @module("@shadcn/react/questionnaire") @scope("Questionnaire")
  external make: React.component<props> = "ChoiceLabel"
}

module ChoiceShortcut = {
  type props = {
    ...elementProps,
  }
  @module("@shadcn/react/questionnaire") @scope("Questionnaire")
  external make: React.component<props> = "ChoiceShortcut"
}

module Input = {
  type props = {
    ...elementProps,
    @as("type")
    type_?: [
      | #date
      | #"datetime-local"
      | #email
      | #month
      | #number
      | #password
      | #search
      | #tel
      | #text
      | #time
      | #url
      | #week
    ],
    value?: string,
    defaultValue?: string,
    placeholder?: string,
    autoComplete?: string,
    min?: string,
    max?: string,
    minLength?: int,
    maxLength?: int,
    pattern?: string,
    required?: bool,
  }
  @module("@shadcn/react/questionnaire") @scope("Questionnaire")
  external make: React.component<props> = "Input"
}

module Error = {
  type props = {
    ...elementProps,
  }
  @module("@shadcn/react/questionnaire") @scope("Questionnaire")
  external make: React.component<props> = "Error"
}

module Previous = {
  type props = {
    ...elementProps,
    @as("type") type_?: [#button | #submit | #reset],
  }
  @module("@shadcn/react/questionnaire") @scope("Questionnaire")
  external make: React.component<props> = "Previous"
  module WithRender = {
    type props = {...renderProps<navigationState>}
    @module("@shadcn/react/questionnaire") @scope("Questionnaire")
    external make: React.component<props> = "Previous"
  }
}

module Skip = {
  type props = {
    ...elementProps,
    @as("type") type_?: [#button | #submit | #reset],
  }
  @module("@shadcn/react/questionnaire") @scope("Questionnaire")
  external make: React.component<props> = "Skip"
  module WithRender = {
    type props = {...renderProps<navigationState>}
    @module("@shadcn/react/questionnaire") @scope("Questionnaire")
    external make: React.component<props> = "Skip"
  }
}

module Next = {
  type props = {
    ...elementProps,
    @as("type") type_?: [#button | #submit | #reset],
  }
  @module("@shadcn/react/questionnaire") @scope("Questionnaire")
  external make: React.component<props> = "Next"
  module WithRender = {
    type props = {...renderProps<navigationState>}
    @module("@shadcn/react/questionnaire") @scope("Questionnaire")
    external make: React.component<props> = "Next"
  }
}

module Submit = {
  type props = {
    ...elementProps,
    @as("type") type_?: [#button | #submit | #reset],
  }
  @module("@shadcn/react/questionnaire") @scope("Questionnaire")
  external make: React.component<props> = "Submit"
  module WithRender = {
    type props = {...renderProps<navigationState>}
    @module("@shadcn/react/questionnaire") @scope("Questionnaire")
    external make: React.component<props> = "Submit"
  }
}
