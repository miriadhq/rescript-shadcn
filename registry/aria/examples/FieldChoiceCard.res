@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Field.Group className="w-full max-w-xs">
    <Field.Set>
      <Field.Legend variant=Label> {"Compute Environment"->React.string} </Field.Legend>
      <Field.Description>
        {"Select the compute environment for your cluster."->React.string}
      </Field.Description>
      <RadioGroup defaultValue="kubernetes">
        <Field.Label htmlFor="kubernetes-r2h">
          <Field orientation=Horizontal>
            <Field.Content>
              <Field.Title> {"Kubernetes"->React.string} </Field.Title>
              <Field.Description>
                {"Run GPU workloads on a K8s cluster."->React.string}
              </Field.Description>
            </Field.Content>
            <RadioGroup.Item value="kubernetes" id="kubernetes-r2h" />
          </Field>
        </Field.Label>
        <Field.Label htmlFor="vm-z4k">
          <Field orientation=Horizontal>
            <Field.Content>
              <Field.Title> {"Virtual Machine"->React.string} </Field.Title>
              <Field.Description>
                {"Access a cluster to run GPU workloads."->React.string}
              </Field.Description>
            </Field.Content>
            <RadioGroup.Item value="vm" id="vm-z4k" />
          </Field>
        </Field.Label>
      </RadioGroup>
    </Field.Set>
  </Field.Group>
