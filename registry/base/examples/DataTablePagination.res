module RT = DataTableDemo.RT

type paginationState = {pageSize: int, pageIndex: int}
type tableState = {pagination: paginationState}

@send external getState: RT.t<'data> => tableState = "getState"
@send external getPageCount: RT.t<'data> => int = "getPageCount"
@send external setPageIndex: (RT.t<'data>, int) => unit = "setPageIndex"
@send external setPageSize: (RT.t<'data>, int) => unit = "setPageSize"

@react.component
let make = (~table: RT.t<'data>) => {
  let state = table->getState
  let pageCount = table->getPageCount

  <div className="flex items-center justify-between px-2">
    <div className="flex-1 text-sm text-muted-foreground">
      {(table->RT.getFilteredSelectedRowModel).rows->Array.length->Int.toString->React.string}
      {" of "->React.string}
      {(table->RT.getFilteredRowModel).rows->Array.length->Int.toString->React.string}
      {" row(s) selected."->React.string}
    </div>
    <div className="flex items-center space-x-6 lg:space-x-8">
      <div className="flex items-center space-x-2">
        <p className="text-sm font-medium"> {"Rows per page"->React.string} </p>
        <Select
          value={state.pagination.pageSize->Int.toString}
          onValueChange={(value, _) => table->setPageSize(Int.fromString(value)->Option.getOr(10))}
        >
          <Select.Trigger className="h-8 w-[70px]">
            <Select.Value placeholder={state.pagination.pageSize->Int.toString} />
          </Select.Trigger>
          <Select.Content side=BaseUi.Types.Side.Top>
            {[10, 20, 25, 30, 40, 50]
            ->Array.map(pageSize =>
              <Select.Item key={pageSize->Int.toString} value={pageSize->Int.toString}>
                {pageSize->Int.toString->React.string}
              </Select.Item>
            )
            ->React.array}
          </Select.Content>
        </Select>
      </div>
      <div className="flex w-[100px] items-center justify-center text-sm font-medium">
        {`Page ${(state.pagination.pageIndex + 1)
            ->Int.toString} of ${pageCount->Int.toString}`->React.string}
      </div>
      <div className="flex items-center space-x-2">
        <Button
          variant=Button.Variant.Outline
          size=Button.Size.Icon
          className="hidden size-8 lg:flex"
          onClick={_ => table->setPageIndex(0)}
          disabled={!(table->RT.getCanPreviousPage)}
        >
          <span className="sr-only"> {"Go to first page"->React.string} </span>
          <Icons.ChevronsLeft />
        </Button>
        <Button
          variant=Button.Variant.Outline
          size=Button.Size.Icon
          className="size-8"
          onClick={_ => table->RT.previousPage}
          disabled={!(table->RT.getCanPreviousPage)}
        >
          <span className="sr-only"> {"Go to previous page"->React.string} </span>
          <Icons.ChevronLeft />
        </Button>
        <Button
          variant=Button.Variant.Outline
          size=Button.Size.Icon
          className="size-8"
          onClick={_ => table->RT.nextPage}
          disabled={!(table->RT.getCanNextPage)}
        >
          <span className="sr-only"> {"Go to next page"->React.string} </span>
          <Icons.ChevronRight />
        </Button>
        <Button
          variant=Button.Variant.Outline
          size=Button.Size.Icon
          className="hidden size-8 lg:flex"
          onClick={_ => table->setPageIndex(pageCount - 1)}
          disabled={!(table->RT.getCanNextPage)}
        >
          <span className="sr-only"> {"Go to last page"->React.string} </span>
          <Icons.ChevronsRight />
        </Button>
      </div>
    </div>
  </div>
}
