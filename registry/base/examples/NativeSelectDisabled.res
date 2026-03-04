@react.component
let make = () =>
  <NativeSelect disabled={true}>
    <NativeSelect.Option value=""> {"Disabled"->React.string} </NativeSelect.Option>
    <NativeSelect.Option value="apple"> {"Apple"->React.string} </NativeSelect.Option>
    <NativeSelect.Option value="banana"> {"Banana"->React.string} </NativeSelect.Option>
    <NativeSelect.Option value="blueberry"> {"Blueberry"->React.string} </NativeSelect.Option>
  </NativeSelect>
