@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <NativeSelect dir="rtl">
    <NativeSelect.Option value=""> {"اختر الحالة"->React.string} </NativeSelect.Option>
    <NativeSelect.Option value="todo"> {"مهام"->React.string} </NativeSelect.Option>
    <NativeSelect.Option value="in-progress">
      {"قيد التنفيذ"->React.string}
    </NativeSelect.Option>
    <NativeSelect.Option value="done"> {"منجز"->React.string} </NativeSelect.Option>
    <NativeSelect.Option value="cancelled"> {"ملغي"->React.string} </NativeSelect.Option>
  </NativeSelect>
