@react.component
let make = () =>
  <NativeSelect invalid={true}>
    <NativeSelect.Option value=""> {"Error state"->React.string} </NativeSelect.Option>
    <NativeSelect.Option value="apple"> {"Apple"->React.string} </NativeSelect.Option>
    <NativeSelect.Option value="banana"> {"Banana"->React.string} </NativeSelect.Option>
    <NativeSelect.Option value="blueberry"> {"Blueberry"->React.string} </NativeSelect.Option>
  </NativeSelect>
