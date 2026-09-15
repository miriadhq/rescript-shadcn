module TableIcon = {
  @module("lucide-react") external make: React.component<Icons.props> = "TableIcon"
}

type media =
  | Image({src: string})
  | Icon(React.element)

type item = {name: string, meta: string, media: media}
let items = [
  {
    name: "briefing-notes.pdf",
    meta: "PDF · 1.4 MB",
    media: Icon(<Icons.FileText />),
  },
  {
    name: "workspace.png",
    meta: "PNG · 820 KB",
    media: Image({
      src: "https://images.unsplash.com/photo-1497366754035-f200968a6e72?w=900&auto=format&fit=crop&q=80",
    }),
  },
  {
    name: "customers.csv",
    meta: "CSV · 18 KB",
    media: Icon(<TableIcon />),
  },
  {
    name: "renderer.tsx",
    meta: "TSX · 12 KB",
    media: Icon(<Icons.FileCode />),
  },
]
@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="mx-auto w-full max-w-sm py-12">
    <Attachment.Group className="w-full">
      {items
      ->Array.map(item =>
        <Attachment key=item.name className="w-64">
          {switch item.media {
          | Image({src}) =>
            <Attachment.Media variant=Image>
              <img src=src alt=item.name />
            </Attachment.Media>
          | Icon(icon) => <Attachment.Media> {icon} </Attachment.Media>
          }}
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
