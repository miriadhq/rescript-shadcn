@@directive("'use client'")

module Payment = {
  type t = {id: string, amount: float, status: string, email: string}
}

let tableData: array<Payment.t> = [
  {id: "m5gr84i9", amount: 316., status: "success", email: "ken99@example.com"},
  {id: "3u1reuv4", amount: 242., status: "success", email: "Abe45@example.com"},
  {id: "derv1ws0", amount: 837., status: "processing", email: "Monserrat44@example.com"},
  {id: "5kma53ae", amount: 874., status: "success", email: "Silas22@example.com"},
  {id: "bhqecj4p", amount: 721., status: "failed", email: "carmella@example.com"},
]

module RT = {
  type t<'data>
  module Column = {
    type t
  }
  module Row = {
    type t<'data>
  }
  module Cell = {
    type t
  }
  module Header = {
    type t
  }
  module HeaderGroup = {
    type t
  }
  module RowModel = {
    type t<'data> = {rows: array<Row.t<'data>>}
  }
  module RowModelGetter = {
    type t
  }
  module ColumnDefValue = {
    type t
  }
  module ColumnFilter = {
    type t = {id: string, value: string}
  }
  module ColumnFilters = {
    type t = array<ColumnFilter.t>
  }
  module ColumnVisibility = {
    type t = dict<bool>
  }
  module RowSelection = {
    type t = dict<bool>
  }
  module SortItem = {
    type t = {id: string, desc: bool}
  }
  module Sorting = {
    type t = array<SortItem.t>
  }
  module HeaderContext = {
    type t<'data>
  }
  module CellContext = {
    type t<'data>
  }
  module ColumnDef = {
    type t<'data> = {
      id?: string,
      accessorKey?: string,
      header?: HeaderContext.t<'data> => React.element,
      cell?: CellContext.t<'data> => React.element,
      enableSorting?: bool,
      enableHiding?: bool,
    }
  }
  module State = {
    type t = {
      sorting: Sorting.t,
      columnFilters: ColumnFilters.t,
      columnVisibility: ColumnVisibility.t,
      rowSelection: RowSelection.t,
    }
  }
  module Options = {
    type t<'data> = {
      data: array<'data>,
      columns: array<ColumnDef.t<'data>>,
      getCoreRowModel: RowModelGetter.t,
      getFilteredRowModel: RowModelGetter.t,
      getPaginationRowModel: RowModelGetter.t,
      getSortedRowModel: RowModelGetter.t,
      onSortingChange: (Sorting.t => Sorting.t) => unit,
      onColumnFiltersChange: (ColumnFilters.t => ColumnFilters.t) => unit,
      onColumnVisibilityChange: (ColumnVisibility.t => ColumnVisibility.t) => unit,
      onRowSelectionChange: (RowSelection.t => RowSelection.t) => unit,
      state: State.t,
    }
  }

  @module("@tanstack/react-table") external flexRender: ('a, 'b) => React.element = "flexRender"
  @module("@tanstack/react-table")
  external coreRowModel: unit => RowModelGetter.t = "getCoreRowModel"
  @module("@tanstack/react-table")
  external filteredRowModelGetter: unit => RowModelGetter.t = "getFilteredRowModel"
  @module("@tanstack/react-table")
  external paginationRowModelGetter: unit => RowModelGetter.t = "getPaginationRowModel"
  @module("@tanstack/react-table")
  external sortedRowModelGetter: unit => RowModelGetter.t = "getSortedRowModel"
  @module("@tanstack/react-table")
  external useReactTable: Options.t<'data> => t<'data> = "useReactTable"

  @send external getHeaderGroups: t<'data> => array<HeaderGroup.t> = "getHeaderGroups"
  @send external getRowModel: t<'data> => RowModel.t<'data> = "getRowModel"
  @send external getFilteredRowModel: t<'data> => RowModel.t<'data> = "getFilteredRowModel"
  @send
  external getFilteredSelectedRowModel: t<'data> => RowModel.t<'data> =
    "getFilteredSelectedRowModel"
  @send external getAllColumns: t<'data> => array<Column.t> = "getAllColumns"
  @send external getCanPreviousPage: t<'data> => bool = "getCanPreviousPage"
  @send external getCanNextPage: t<'data> => bool = "getCanNextPage"
  @send external previousPage: t<'data> => unit = "previousPage"
  @send external nextPage: t<'data> => unit = "nextPage"
  @send external getColumn: (t<'data>, string) => nullable<Column.t> = "getColumn"
  @send external getIsAllPageRowsSelected: t<'data> => bool = "getIsAllPageRowsSelected"
  @send external getIsSomePageRowsSelected: t<'data> => bool = "getIsSomePageRowsSelected"
  @send external toggleAllPageRowsSelected: (t<'data>, bool) => unit = "toggleAllPageRowsSelected"

  @get external hdrGroupId: HeaderGroup.t => string = "id"
  @get external hdrGroupHeaders: HeaderGroup.t => array<Header.t> = "headers"

  @get external hdrId: Header.t => string = "id"
  @get external hdrIsPlaceholder: Header.t => bool = "isPlaceholder"
  @send external getHdrCtx: Header.t => HeaderContext.t<'data> = "getContext"
  @get external hdrCol: Header.t => Column.t = "column"

  @get external colColDef: Column.t => ColumnDefValue.t = "columnDef"
  @get external colDefHdr: ColumnDefValue.t => 'a = "header"
  @get external colDefCell: ColumnDefValue.t => 'a = "cell"

  @get external colId: Column.t => string = "id"
  @send external colGetCanHide: Column.t => bool = "getCanHide"
  @send external colGetIsVisible: Column.t => bool = "getIsVisible"
  @send external colToggleVisibility: (Column.t, bool) => unit = "toggleVisibility"
  @send external colGetIsSorted: Column.t => string = "getIsSorted"
  @send external colToggleSorting: (Column.t, bool) => unit = "toggleSorting"
  @send external colGetFilterValue: Column.t => nullable<string> = "getFilterValue"
  @send external colSetFilterValue: (Column.t, string) => unit = "setFilterValue"

  @get external rowId: Row.t<'data> => string = "id"
  @send external rowGetIsSelected: Row.t<'data> => bool = "getIsSelected"
  @send external rowToggleSelected: (Row.t<'data>, bool) => unit = "toggleSelected"
  @send external rowGetVisibleCells: Row.t<'data> => array<Cell.t> = "getVisibleCells"
  @get external rowOriginal: Row.t<'data> => 'data = "original"
  @send external rowGetValue: (Row.t<'data>, string) => 'a = "getValue"

  @get external cellId: Cell.t => string = "id"
  @send external getCellCtx: Cell.t => CellContext.t<'data> = "getContext"
  @get external cellCol: Cell.t => Column.t = "column"

  @get external ctxRow: CellContext.t<'data> => Row.t<'data> = "row"
  @get external ctxCol: HeaderContext.t<'data> => Column.t = "column"
  @get external ctxTable: HeaderContext.t<'data> => t<'data> = "table"
}

module NumberFormat = {
  type t
}
module NumberFormatOpts = {
  type t = {style: string, currency: string}
}
@scope("Intl") @new
external makeNumberFormat: (string, NumberFormatOpts.t) => NumberFormat.t = "NumberFormat"
@send external formatAmount: (NumberFormat.t, float) => string = "format"

@scope(("navigator", "clipboard")) @val
external writeText: string => promise<unit> = "writeText"

let columns: array<RT.ColumnDef.t<Payment.t>> = [
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
          ({style: "currency", currency: "USD"}: NumberFormatOpts.t),
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
