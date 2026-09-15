@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex items-center justify-between gap-4">
    <Field orientation=Horizontal className="w-fit">
      <Field.Label htmlFor="select-rows-per-page"> {"Rows per page"->React.string} </Field.Label>
      <Select defaultValue="25">
        <Select.Trigger className="w-20" id="select-rows-per-page">
          <Select.Value />
        </Select.Trigger>
        <Select.Content placement=ReactAria.Common.BottomStart>
          <Select.Group>
            <Select.Item id="10"> {"10"->React.string} </Select.Item>
            <Select.Item id="25"> {"25"->React.string} </Select.Item>
            <Select.Item id="50"> {"50"->React.string} </Select.Item>
            <Select.Item id="100"> {"100"->React.string} </Select.Item>
          </Select.Group>
        </Select.Content>
      </Select>
    </Field>
    <Pagination className="mx-0 w-auto">
      <Pagination.Content>
        <Pagination.Item>
          <Pagination.Previous href="#" />
        </Pagination.Item>
        <Pagination.Item>
          <Pagination.Next href="#" />
        </Pagination.Item>
      </Pagination.Content>
    </Pagination>
  </div>
