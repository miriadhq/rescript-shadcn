@@directive("'use client'")

type fileItem = {
  id: string,
  name: string,
  progress: float,
  timeRemaining: string,
}

@react.component
let make = () => {
  let files = [
    {id: "1", name: "document.pdf", progress: 45., timeRemaining: "2m 30s"},
    {id: "2", name: "presentation.pptx", progress: 78., timeRemaining: "45s"},
    {id: "3", name: "spreadsheet.xlsx", progress: 12., timeRemaining: "5m 12s"},
    {id: "4", name: "image.jpg", progress: 100., timeRemaining: "Complete"},
  ]

  <Item.Group>
    {files
    ->Array.map(file =>
      <Item key={file.id} size=Item.Size.Xs className="px-0">
        <Item.Media variant=Item.Media.Variant.Icon>
          <Icons.File className="size-5" />
        </Item.Media>
        <Item.Content className="inline-block truncate">
          <Item.Title className="inline"> {file.name->React.string} </Item.Title>
        </Item.Content>
        <Item.Content>
          <Progress value={file.progress} className="w-32" />
        </Item.Content>
        <Item.Actions className="w-16 justify-end">
          <span className="text-muted-foreground text-sm">
            {file.timeRemaining->React.string}
          </span>
        </Item.Actions>
      </Item>
    )
    ->React.array}
  </Item.Group>
}
