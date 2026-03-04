@@jsxConfig({version: 4, mode: "automatic", module_: "BaseUi.BaseUiJsxDOM"})

@@directive("'use client'")

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
  type colFilters
  type colVisibility
  type rowSel
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
  @send external colGetFilterValue: col => string = "getFilterValue"
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
