@@directive("'use client'")

@react.component
let make = () =>
  <Table dir="rtl">
    <Table.Caption> {"قائمة بفواتيرك الأخيرة."->React.string} </Table.Caption>
    <Table.Header>
      <Table.Row>
        <Table.Head className="w-[100px]"> {"الفاتورة"->React.string} </Table.Head>
        <Table.Head> {"الحالة"->React.string} </Table.Head>
        <Table.Head> {"الطريقة"->React.string} </Table.Head>
        <Table.Head className="text-right"> {"المبلغ"->React.string} </Table.Head>
      </Table.Row>
    </Table.Header>
    <Table.Body>
      <Table.Row>
        <Table.Cell className="font-medium"> {"INV001"->React.string} </Table.Cell>
        <Table.Cell> {"مدفوع"->React.string} </Table.Cell>
        <Table.Cell> {"بطاقة ائتمانية"->React.string} </Table.Cell>
        <Table.Cell className="text-right"> {"$250.00"->React.string} </Table.Cell>
      </Table.Row>
      <Table.Row>
        <Table.Cell className="font-medium"> {"INV002"->React.string} </Table.Cell>
        <Table.Cell> {"قيد الانتظار"->React.string} </Table.Cell>
        <Table.Cell> {"PayPal"->React.string} </Table.Cell>
        <Table.Cell className="text-right"> {"$150.00"->React.string} </Table.Cell>
      </Table.Row>
      <Table.Row>
        <Table.Cell className="font-medium"> {"INV003"->React.string} </Table.Cell>
        <Table.Cell> {"غير مدفوع"->React.string} </Table.Cell>
        <Table.Cell> {"تحويل بنكي"->React.string} </Table.Cell>
        <Table.Cell className="text-right"> {"$350.00"->React.string} </Table.Cell>
      </Table.Row>
      <Table.Row>
        <Table.Cell className="font-medium"> {"INV004"->React.string} </Table.Cell>
        <Table.Cell> {"مدفوع"->React.string} </Table.Cell>
        <Table.Cell> {"بطاقة ائتمانية"->React.string} </Table.Cell>
        <Table.Cell className="text-right"> {"$450.00"->React.string} </Table.Cell>
      </Table.Row>
      <Table.Row>
        <Table.Cell className="font-medium"> {"INV005"->React.string} </Table.Cell>
        <Table.Cell> {"مدفوع"->React.string} </Table.Cell>
        <Table.Cell> {"PayPal"->React.string} </Table.Cell>
        <Table.Cell className="text-right"> {"$550.00"->React.string} </Table.Cell>
      </Table.Row>
      <Table.Row>
        <Table.Cell className="font-medium"> {"INV006"->React.string} </Table.Cell>
        <Table.Cell> {"قيد الانتظار"->React.string} </Table.Cell>
        <Table.Cell> {"تحويل بنكي"->React.string} </Table.Cell>
        <Table.Cell className="text-right"> {"$200.00"->React.string} </Table.Cell>
      </Table.Row>
      <Table.Row>
        <Table.Cell className="font-medium"> {"INV007"->React.string} </Table.Cell>
        <Table.Cell> {"غير مدفوع"->React.string} </Table.Cell>
        <Table.Cell> {"بطاقة ائتمانية"->React.string} </Table.Cell>
        <Table.Cell className="text-right"> {"$300.00"->React.string} </Table.Cell>
      </Table.Row>
    </Table.Body>
    <Table.Footer>
      <Table.Row>
        <Table.Cell colSpan={3}> {"المجموع"->React.string} </Table.Cell>
        <Table.Cell className="text-right"> {"$2,500.00"->React.string} </Table.Cell>
      </Table.Row>
    </Table.Footer>
  </Table>
