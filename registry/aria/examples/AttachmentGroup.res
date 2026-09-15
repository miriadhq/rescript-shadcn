module TableIcon = {
  @module("lucide-react") external make: React.component<Icons.props> = "TableIcon"
}

type item = {name: string, meta: string, media: React.element}
let items = [
  {
    name: "briefing-notes.pdf",
    meta: "PDF · 1.4 MB",
    media: <Attachment.Media>
      <Icons.FileText />
    </Attachment.Media>,
  },
  {
    name: "workspace.png",
    meta: "PNG · 820 KB",
    media: <Attachment.Media variant=Image>
      <img
        src="https://images.unsplash.com/photo-1497366754035-f200968a6e72?w=900&auto=format&fit=crop&q=80"
        alt="workspace.png"
      />
    </Attachment.Media>,
  },
  {
    name: "customers.csv",
    meta: "CSV · 18 KB",
    media: <Attachment.Media>
      <TableIcon />
    </Attachment.Media>,
  },
  {
    name: "renderer.tsx",
    meta: "TSX · 12 KB",
    media: <Attachment.Media>
      <Icons.FileCode />
    </Attachment.Media>,
  },
]
@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="mx-auto w-full max-w-sm py-12">
    <Attachment.Group className="w-full">
      {items
      ->Array.map(item =>
        <Attachment key=item.name className="w-64">
          {item.media}
          <Attachment.Content>
            <Attachment.Title> {item.name->React.string} </Attachment.Title>
            <Attachment.Description> {item.meta->React.string} </Attachment.Description>
          </Attachment.Content>
          <Attachment.Actions>
            <Attachment.Action ariaLabel={"Remove " ++ item.name}>
              <Icons.X />
            </Attachment.Action>
          </Attachment.Actions>
        </Attachment>
      )
      ->React.array}
    </Attachment.Group>
  </div>
