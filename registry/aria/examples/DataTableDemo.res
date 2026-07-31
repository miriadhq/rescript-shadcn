@@directive("'use client'")

type payment = {id: string, amount: float, status: string, email: string}

let tableData: array<payment> = [
  {id: "m5gr84i9", amount: 316., status: "success", email: "ken99@example.com"},
  {id: "3u1reuv4", amount: 242., status: "success", email: "Abe45@example.com"},
  {id: "derv1ws0", amount: 837., status: "processing", email: "Monserrat44@example.com"},
  {id: "5kma53ae", amount: 874., status: "success", email: "Silas22@example.com"},
  {id: "bhqecj4p", amount: 721., status: "failed", email: "carmella@example.com"},
]

module RT = {
  type t<'data>
  type col
  type row<'data>
  type cell
  type hdr
  type hdrGroup
  type rowModel<'data> = {rows: array<row<'data>>}
  type rowModelGetter
  type colDef_
  type colFilter = {id: string, value: string}
  type colFilters = array<colFilter>
  type colVisibility = dict<bool>
  type rowSel = dict<bool>
  type sortItem = {id: string, desc: bool}
  type sorting = array<sortItem>
  type hdrCtx<'data>
  type cellCtx<'data>

  type colDef<'data> = {
    id?: string,
    accessorKey?: string,
    header?: hdrCtx<'data> => React.element,
    cell?: cellCtx<'data> => React.element,
    enableSorting?: bool,
    enableHiding?: bool,
  }

  type state = {
    sorting: sorting,
    columnFilters: colFilters,
    columnVisibility: colVisibility,
    rowSelection: rowSel,
  }

  type options<'data> = {
    data: array<'data>,
    columns: array<colDef<'data>>,
    getCoreRowModel: rowModelGetter,
    getFilteredRowModel: rowModelGetter,
    getPaginationRowModel: rowModelGetter,
    getSortedRowModel: rowModelGetter,
    onSortingChange: (sorting => sorting) => unit,
    onColumnFiltersChange: (colFilters => colFilters) => unit,
    onColumnVisibilityChange: (colVisibility => colVisibility) => unit,
    onRowSelectionChange: (rowSel => rowSel) => unit,
    state: state,
  }

  @module("@tanstack/react-table") external flexRender: ('a, 'b) => React.element = "flexRender"
  @module("@tanstack/react-table") external coreRowModel: unit => rowModelGetter = "getCoreRowModel"
  @module("@tanstack/react-table")
  external filteredRowModelGetter: unit => rowModelGetter = "getFilteredRowModel"
  @module("@tanstack/react-table")
  external paginationRowModelGetter: unit => rowModelGetter = "getPaginationRowModel"
  @module("@tanstack/react-table")
  external sortedRowModelGetter: unit => rowModelGetter = "getSortedRowModel"
  @module("@tanstack/react-table")
  external useReactTable: options<'data> => t<'data> = "useReactTable"

  @send external getHeaderGroups: t<'data> => array<hdrGroup> = "getHeaderGroups"
  @send external getRowModel: t<'data> => rowModel<'data> = "getRowModel"
  @send external getFilteredRowModel: t<'data> => rowModel<'data> = "getFilteredRowModel"
  @send
  external getFilteredSelectedRowModel: t<'data> => rowModel<'data> = "getFilteredSelectedRowModel"
  @send external getAllColumns: t<'data> => array<col> = "getAllColumns"
  @send external getCanPreviousPage: t<'data> => bool = "getCanPreviousPage"
  @send external getCanNextPage: t<'data> => bool = "getCanNextPage"
  @send external previousPage: t<'data> => unit = "previousPage"
  @send external nextPage: t<'data> => unit = "nextPage"
  @send external getColumn: (t<'data>, string) => Nullable.t<col> = "getColumn"
  @send external getIsAllPageRowsSelected: t<'data> => bool = "getIsAllPageRowsSelected"
  @send external getIsSomePageRowsSelected: t<'data> => bool = "getIsSomePageRowsSelected"
  @send external toggleAllPageRowsSelected: (t<'data>, bool) => unit = "toggleAllPageRowsSelected"

  @get external hdrGroupId: hdrGroup => string = "id"
  @get external hdrGroupHeaders: hdrGroup => array<hdr> = "headers"

  @get external hdrId: hdr => string = "id"
  @get external hdrIsPlaceholder: hdr => bool = "isPlaceholder"
  @send external getHdrCtx: hdr => hdrCtx<'data> = "getContext"
  @get external hdrCol: hdr => col = "column"

  @get external colColDef: col => colDef_ = "columnDef"
  @get external colDefHdr: colDef_ => 'a = "header"
  @get external colDefCell: colDef_ => 'a = "cell"

  @get external colId: col => string = "id"
  @send external colGetCanHide: col => bool = "getCanHide"
  @send external colGetIsVisible: col => bool = "getIsVisible"
  @send external colToggleVisibility: (col, bool) => unit = "toggleVisibility"
  @send external colGetIsSorted: col => string = "getIsSorted"
  @send external colToggleSorting: (col, bool) => unit = "toggleSorting"
  @send external colGetFilterValue: col => Nullable.t<string> = "getFilterValue"
  @send external colSetFilterValue: (col, string) => unit = "setFilterValue"

  @get external rowId: row<'data> => string = "id"
  @send external rowGetIsSelected: row<'data> => bool = "getIsSelected"
  @send external rowToggleSelected: (row<'data>, bool) => unit = "toggleSelected"
  @send external rowGetVisibleCells: row<'data> => array<cell> = "getVisibleCells"
  @get external rowOriginal: row<'data> => 'data = "original"
  @send external rowGetValue: (row<'data>, string) => 'a = "getValue"

  @get external cellId: cell => string = "id"
  @send external getCellCtx: cell => cellCtx<'data> = "getContext"
  @get external cellCol: cell => col = "column"

  @get external ctxRow: cellCtx<'data> => row<'data> = "row"
  @get external ctxCol: hdrCtx<'data> => col = "column"
  @get external ctxTable: hdrCtx<'data> => t<'data> = "table"
}

type numberFormat
type numberFormatOpts = {style: string, currency: string}
@scope("Intl") @new
external makeNumberFormat: (string, numberFormatOpts) => numberFormat = "NumberFormat"
@send external formatAmount: (numberFormat, float) => string = "format"

@scope(("navigator", "clipboard")) @val
external writeText: string => promise<unit> = "writeText"

let columns: array<RT.colDef<payment>> = [
  {
    id: "select",
    header: ctx => {
      let table = ctx->RT.ctxTable
      <Checkbox
        checked={table->RT.getIsAllPageRowsSelected || table->RT.getIsSomePageRowsSelected}
        onCheckedChange={(v, _) => table->RT.toggleAllPageRowsSelected(v)}
        ariaLabel="Select all"
      />
    },
    cell: ctx => {
      let row = ctx->RT.ctxRow
      <Checkbox
        checked={row->RT.rowGetIsSelected}
        onCheckedChange={(v, _) => row->RT.rowToggleSelected(v)}
        ariaLabel="Select row"
      />
    },
    enableSorting: false,
    enableHiding: false,
  },
  {
    accessorKey: "status",
    header: _ => "Status"->React.string,
    cell: ctx => {
      let row = ctx->RT.ctxRow
      <div className="capitalize"> {(row->RT.rowGetValue("status"): string)->React.string} </div>
    },
  },
  {
    accessorKey: "email",
    header: ctx => {
      let col = ctx->RT.ctxCol
      <Button
        variant=Ghost onClick={_ => col->RT.colToggleSorting(col->RT.colGetIsSorted == "asc")}
      >
        {"Email"->React.string}
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
    header: _ => <div className="text-right"> {"Amount"->React.string} </div>,
    cell: ctx => {
      let row = ctx->RT.ctxRow
      let amount: float = row->RT.rowGetValue("amount")
      let formatted =
        makeNumberFormat(
          "en-US",
          ({style: "currency", currency: "USD"}: numberFormatOpts),
        )->formatAmount(amount)
      <div className="text-right font-medium"> {formatted->React.string} </div>
    },
  },
  {
    id: "actions",
    enableHiding: false,
    cell: ctx => {
      let payment = ctx->RT.ctxRow->RT.rowOriginal
      <DropdownMenu>
        <DropdownMenu.Trigger render={<Button variant=Ghost size=IconXs />}>
          <span className="sr-only"> {"Open menu"->React.string} </span>
          <Icons.MoreHorizontal />
        </DropdownMenu.Trigger>
        <DropdownMenu.Content align=End className="w-44">
          <DropdownMenu.Group>
            <DropdownMenu.Label> {"Actions"->React.string} </DropdownMenu.Label>
            <DropdownMenu.Item
              onClick={_ => {
                let _ = writeText(payment.id)
              }}
            >
              {"Copy payment ID"->React.string}
            </DropdownMenu.Item>
          </DropdownMenu.Group>
          <DropdownMenu.Separator />
          <DropdownMenu.Group>
            <DropdownMenu.Item> {"View customer"->React.string} </DropdownMenu.Item>
            <DropdownMenu.Item> {"View payment details"->React.string} </DropdownMenu.Item>
          </DropdownMenu.Group>
        </DropdownMenu.Content>
      </DropdownMenu>
    },
  },
]

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (sorting, setSorting) = React.useState(() => [])
  let (colFilters, setColFilters) = React.useState(() => [])
  let (colVisibility, setColVisibility) = React.useState(() => dict{})
  let (rowSelection, setRowSelection) = React.useState(() => dict{})

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
    ->Option.flatMap(col => col->RT.colGetFilterValue->Nullable.toOption)
    ->Option.getOr("")

  <div className="w-full">
    <div className="flex items-center py-4">
      <Input
        placeholder="Filter emails..."
        value={emailFilterValue}
        onValueChange={(value, _) =>
          table
          ->RT.getColumn("email")
          ->Nullable.toOption
          ->Option.forEach(col => col->RT.colSetFilterValue(value))}
        className="max-w-sm"
      />
      <DropdownMenu>
        <DropdownMenu.Trigger render={<Button variant=Outline className="ml-auto" />}>
          {"Columns"->React.string}
          <Icons.ChevronDown />
        </DropdownMenu.Trigger>
        <DropdownMenu.Content align=End className="w-44">
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
                {"No results."->React.string}
              </Table.Cell>
            </Table.Row>
          }}
        </Table.Body>
      </Table>
    </div>
    <div className="flex items-center justify-end space-x-2 py-4">
      <div className="text-muted-foreground flex-1 text-sm">
        {(table->RT.getFilteredSelectedRowModel).rows->Array.length->Int.toString->React.string}
        {" of "->React.string}
        {(table->RT.getFilteredRowModel).rows->Array.length->Int.toString->React.string}
        {" row(s) selected."->React.string}
      </div>
      <div className="space-x-2">
        <Button
          variant=Outline
          size=Sm
          onClick={_ => table->RT.previousPage}
          disabled={!(table->RT.getCanPreviousPage)}
        >
          {"Previous"->React.string}
        </Button>
        <Button
          variant=Outline
          size=Sm
          onClick={_ => table->RT.nextPage}
          disabled={!(table->RT.getCanNextPage)}
        >
          {"Next"->React.string}
        </Button>
      </div>
    </div>
  </div>
}
