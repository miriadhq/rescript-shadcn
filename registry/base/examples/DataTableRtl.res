@@directive("'use client'")

module RT = RtlDataTable.RT

type payment = {id: string, amount: float, status: string, email: string}

let tableData: array<payment> = [
  {id: "m5gr84i9", amount: 316., status: "success", email: "ken99@example.com"},
  {id: "3u1reuv4", amount: 242., status: "success", email: "Abe45@example.com"},
  {id: "derv1ws0", amount: 837., status: "processing", email: "Monserrat44@example.com"},
  {id: "5kma53ae", amount: 874., status: "success", email: "Silas22@example.com"},
  {id: "bhqecj4p", amount: 721., status: "failed", email: "carmella@example.com"},
]

type numberFormat
type numberFormatOpts = {style: string, currency: string}
@scope("Intl") @new
external makeNumberFormat: (string, numberFormatOpts) => numberFormat = "NumberFormat"
@send external formatAmount: (numberFormat, float) => string = "format"

@scope(("navigator", "clipboard")) @val
external writeText: string => promise<unit> = "writeText"

let statusMapAr = Dict.fromArray([
  ("success", "ناجح"),
  ("processing", "قيد المعالجة"),
  ("failed", "فشل"),
  ("pending", "قيد الانتظار"),
])

let columns: array<RT.colDef<payment>> = [
  {
    id: "select",
    header: ctx => {
      let table = ctx->RT.ctxTable
      <Checkbox
        checked={table->RT.getIsAllPageRowsSelected || table->RT.getIsSomePageRowsSelected}
        onCheckedChange={(v, _) => table->RT.toggleAllPageRowsSelected(v)}
        ariaLabel="تحديد الكل"
      />
    },
    cell: ctx => {
      let row = ctx->RT.ctxRow
      <Checkbox
        checked={row->RT.rowGetIsSelected}
        onCheckedChange={(v, _) => row->RT.rowToggleSelected(v)}
        ariaLabel="تحديد الصف"
      />
    },
    enableSorting: false,
    enableHiding: false,
  },
  {
    accessorKey: "status",
    header: _ => "الحالة"->React.string,
    cell: ctx => {
      let row = ctx->RT.ctxRow
      let status: string = row->RT.rowGetValue("status")
      <div className="capitalize">
        {statusMapAr->Dict.get(status)->Option.getOr(status)->React.string}
      </div>
    },
  },
  {
    accessorKey: "email",
    header: ctx => {
      let col = ctx->RT.ctxCol
      <Button
        variant=Button.Variant.Ghost
        onClick={_ => col->RT.colToggleSorting(col->RT.colGetIsSorted == "asc")}
      >
        {"البريد الإلكتروني"->React.string}
        <Icons.SortAsc />
      </Button>
    },
    cell: ctx => {
      let row = ctx->RT.ctxRow
      <div className="lowercase"> {(row->RT.rowGetValue("email"): string)->React.string} </div>
    },
  },
  {
    accessorKey: "amount",
    header: _ => <div className="text-start"> {"المبلغ"->React.string} </div>,
    cell: ctx => {
      let row = ctx->RT.ctxRow
      let amount: float = row->RT.rowGetValue("amount")
      let formatted =
        makeNumberFormat(
          "ar-SA",
          ({style: "currency", currency: "USD"}: numberFormatOpts),
        )->formatAmount(amount)
      <div className="text-start font-medium"> {formatted->React.string} </div>
    },
  },
  {
    id: "actions",
    enableHiding: false,
    cell: ctx => {
      let payment = ctx->RT.ctxRow->RT.rowOriginal
      <DropdownMenu>
        <DropdownMenu.Trigger
          render={<Button variant=Button.Variant.Ghost size=Button.Size.IconXs />}
        >
          <span className="sr-only"> {"فتح القائمة"->React.string} </span>
          <Icons.MoreHorizontal />
        </DropdownMenu.Trigger>
        <DropdownMenu.Content align=BaseUi.Types.Align.Start dataLang="ar" className="w-40">
          <DropdownMenu.Group>
            <DropdownMenu.Label> {"الإجراءات"->React.string} </DropdownMenu.Label>
            <DropdownMenu.Item
              onClick={_ => {
                let _ = writeText(payment.id)
              }}
            >
              {"نسخ معرف الدفع"->React.string}
            </DropdownMenu.Item>
          </DropdownMenu.Group>
          <DropdownMenu.Separator />
          <DropdownMenu.Group>
            <DropdownMenu.Item> {"عرض العميل"->React.string} </DropdownMenu.Item>
            <DropdownMenu.Item>
              {"عرض تفاصيل الدفع"->React.string}
            </DropdownMenu.Item>
          </DropdownMenu.Group>
        </DropdownMenu.Content>
      </DropdownMenu>
    },
  },
]

@react.component
let make = () => {
  let (sorting, setSorting) = React.useState((): RT.sorting => [])
  let (colFilters, setColFilters) = React.useState((): RT.colFilters => Obj.magic([]))
  let (colVisibility, setColVisibility) = React.useState((): RT.colVisibility =>
    Obj.magic(Dict.make())
  )
  let (rowSelection, setRowSelection) = React.useState((): RT.rowSel => Obj.magic(Dict.make()))

  let table = RT.useReactTable({
    data: tableData,
    columns,
    getCoreRowModel: RT.coreRowModel(),
    getFilteredRowModel: RT.filteredRowModelGetter(),
    getPaginationRowModel: RT.paginationRowModelGetter(),
    getSortedRowModel: RT.sortedRowModelGetter(),
    onSortingChange: setSorting,
    onColumnFiltersChange: setColFilters,
    onColumnVisibilityChange: setColVisibility,
    onRowSelectionChange: setRowSelection,
    state: {
      sorting,
      columnFilters: colFilters,
      columnVisibility: colVisibility,
      rowSelection,
    },
  })

  let emailFilterValue =
    table
    ->RT.getColumn("email")
    ->Nullable.toOption
    ->Option.map(RT.colGetFilterValue)
    ->Option.getOr("")

  <div className="w-full">
    <div className="flex items-center gap-2 py-4">
      <Input
        placeholder="تصفية البريد الإلكتروني..."
        value={emailFilterValue}
        onValueChange={(value, _) =>
          table
          ->RT.getColumn("email")
          ->Nullable.toOption
          ->Option.forEach(col => col->RT.colSetFilterValue(value))}
        className="max-w-sm"
      />
      <DropdownMenu>
        <DropdownMenu.Trigger
          render={<Button variant=Button.Variant.Outline className="ms-auto" />}
        >
          {"الأعمدة"->React.string}
          <Icons.ChevronDown />
        </DropdownMenu.Trigger>
        <DropdownMenu.Content align=BaseUi.Types.Align.Start dataLang="ar">
          <DropdownMenu.Group>
            {table
            ->RT.getAllColumns
            ->Array.filter(RT.colGetCanHide)
            ->Array.map(col =>
              <DropdownMenu.CheckboxItem
                key={col->RT.colId}
                className="capitalize"
                checked={col->RT.colGetIsVisible}
                onCheckedChange={(v, _) => col->RT.colToggleVisibility(v)}
              >
                {col->RT.colId->React.string}
              </DropdownMenu.CheckboxItem>
            )
            ->React.array}
          </DropdownMenu.Group>
        </DropdownMenu.Content>
      </DropdownMenu>
    </div>
    <div className="overflow-hidden rounded-md border">
      <Table>
        <Table.Header>
          {table
          ->RT.getHeaderGroups
          ->Array.map(hdrGroup =>
            <Table.Row key={hdrGroup->RT.hdrGroupId}>
              {hdrGroup
              ->RT.hdrGroupHeaders
              ->Array.map(hdr =>
                <Table.Head key={hdr->RT.hdrId}>
                  {hdr->RT.hdrIsPlaceholder
                    ? React.null
                    : RT.flexRender(hdr->RT.hdrCol->RT.colColDef->RT.colDefHdr, hdr->RT.getHdrCtx)}
                </Table.Head>
              )
              ->React.array}
            </Table.Row>
          )
          ->React.array}
        </Table.Header>
        <Table.Body>
          {if (table->RT.getRowModel).rows->Array.length > 0 {
            (table->RT.getRowModel).rows
            ->Array.map(row =>
              <Table.Row
                key={row->RT.rowId} dataState=?{row->RT.rowGetIsSelected ? Some("selected") : None}
              >
                {row
                ->RT.rowGetVisibleCells
                ->Array.map(cell =>
                  <Table.Cell key={cell->RT.cellId}>
                    {RT.flexRender(
                      cell->RT.cellCol->RT.colColDef->RT.colDefCell,
                      cell->RT.getCellCtx,
                    )}
                  </Table.Cell>
                )
                ->React.array}
              </Table.Row>
            )
            ->React.array
          } else {
            <Table.Row>
              <Table.Cell colSpan={columns->Array.length} className="h-24 text-center">
                {"لا توجد نتائج."->React.string}
              </Table.Cell>
            </Table.Row>
          }}
        </Table.Body>
      </Table>
    </div>
    <div className="flex items-center justify-end gap-2 py-4">
      <div className="text-muted-foreground flex-1 text-sm">
        {(table->RT.getFilteredSelectedRowModel).rows->Array.length->Int.toString->React.string}
        {" من "->React.string}
        {(table->RT.getFilteredRowModel).rows->Array.length->Int.toString->React.string}
        {" صف(وف) محدد."->React.string}
      </div>
      <div className="flex gap-2">
        <Button
          variant=Button.Variant.Outline
          size=Button.Size.Sm
          onClick={_ => table->RT.previousPage}
          disabled={!(table->RT.getCanPreviousPage)}
        >
          {"السابق"->React.string}
        </Button>
        <Button
          variant=Button.Variant.Outline
          size=Button.Size.Sm
          onClick={_ => table->RT.nextPage}
          disabled={!(table->RT.getCanNextPage)}
        >
          {"التالي"->React.string}
        </Button>
      </div>
    </div>
  </div>
}
