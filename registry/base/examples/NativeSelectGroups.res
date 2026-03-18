@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <NativeSelect>
    <NativeSelect.Option value=""> {"Select department"->React.string} </NativeSelect.Option>
    <NativeSelect.OptGroup label="Engineering">
      <NativeSelect.Option value="frontend"> {"Frontend"->React.string} </NativeSelect.Option>
      <NativeSelect.Option value="backend"> {"Backend"->React.string} </NativeSelect.Option>
      <NativeSelect.Option value="devops"> {"DevOps"->React.string} </NativeSelect.Option>
    </NativeSelect.OptGroup>
    <NativeSelect.OptGroup label="Sales">
      <NativeSelect.Option value="sales-rep"> {"Sales Rep"->React.string} </NativeSelect.Option>
      <NativeSelect.Option value="account-manager">
        {"Account Manager"->React.string}
      </NativeSelect.Option>
      <NativeSelect.Option value="sales-director">
        {"Sales Director"->React.string}
      </NativeSelect.Option>
    </NativeSelect.OptGroup>
    <NativeSelect.OptGroup label="Operations">
      <NativeSelect.Option value="support">
        {"Customer Support"->React.string}
      </NativeSelect.Option>
      <NativeSelect.Option value="product-manager">
        {"Product Manager"->React.string}
      </NativeSelect.Option>
      <NativeSelect.Option value="ops-manager">
        {"Operations Manager"->React.string}
      </NativeSelect.Option>
    </NativeSelect.OptGroup>
  </NativeSelect>
