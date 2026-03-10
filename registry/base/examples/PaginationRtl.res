@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Pagination dir="rtl">
    <Pagination.Content>
      <Pagination.Item>
        <Pagination.Previous href="#" text="السابق" />
      </Pagination.Item>
      <Pagination.Item>
        <Pagination.Link href="#"> {"١"->React.string} </Pagination.Link>
      </Pagination.Item>
      <Pagination.Item>
        <Pagination.Link href="#" isActive={true}> {"٢"->React.string} </Pagination.Link>
      </Pagination.Item>
      <Pagination.Item>
        <Pagination.Link href="#"> {"٣"->React.string} </Pagination.Link>
      </Pagination.Item>
      <Pagination.Item>
        <Pagination.Ellipsis />
      </Pagination.Item>
      <Pagination.Item>
        <Pagination.Next href="#" text="التالي" />
      </Pagination.Item>
    </Pagination.Content>
  </Pagination>
