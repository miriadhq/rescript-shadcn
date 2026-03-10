@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Pagination>
    <Pagination.Content>
      <Pagination.Item>
        <Pagination.Link href="#"> {"1"->React.string} </Pagination.Link>
      </Pagination.Item>
      <Pagination.Item>
        <Pagination.Link href="#" isActive={true}> {"2"->React.string} </Pagination.Link>
      </Pagination.Item>
      <Pagination.Item>
        <Pagination.Link href="#"> {"3"->React.string} </Pagination.Link>
      </Pagination.Item>
      <Pagination.Item>
        <Pagination.Link href="#"> {"4"->React.string} </Pagination.Link>
      </Pagination.Item>
      <Pagination.Item>
        <Pagination.Link href="#"> {"5"->React.string} </Pagination.Link>
      </Pagination.Item>
    </Pagination.Content>
  </Pagination>
