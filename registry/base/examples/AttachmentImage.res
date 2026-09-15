type imagesItem = {name: string, meta: string, src: string, alt: string}

let images = [
  {
    name: "workspace.png",
    meta: "PNG · 820 KB",
    src: "https://images.unsplash.com/photo-1497366754035-f200968a6e72?w=900&auto=format&fit=crop&q=80",
    alt: "Workspace",
  },
  {
    name: "desk-reference.jpg",
    meta: "JPG · 1.1 MB",
    src: "https://images.unsplash.com/photo-1497215728101-856f4ea42174?w=900&auto=format&fit=crop&q=80",
    alt: "Desk",
  },
  {
    name: "office-reference.jpg",
    meta: "JPG · 940 KB",
    src: "https://images.unsplash.com/photo-1497366811353-6870744d04b2?w=900&auto=format&fit=crop&q=80",
    alt: "Office",
  },
]

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="mx-auto w-full max-w-sm py-12">
    <Attachment.Group className="w-full">
      {images
      ->Array.map(image =>
        <Attachment key={image.name} orientation=Vertical>
          <Attachment.Media variant=Image>
            <img src={image.src} alt={image.alt} />
          </Attachment.Media>
          <Attachment.Content>
            <Attachment.Title> {image.name->React.string} </Attachment.Title>
            <Attachment.Description> {image.meta->React.string} </Attachment.Description>
          </Attachment.Content>
          <Attachment.Actions>
            <Attachment.Action ariaLabel={"Remove " ++ image.name ++ ""}>
              <Icons.X />
            </Attachment.Action>
          </Attachment.Actions>
          <Attachment.Trigger
            render={<a
              href={image.src}
              target="_blank"
              rel="noreferrer"
              ariaLabel={"Open " ++ image.name ++ ""}
            />}
          />
        </Attachment>
      )
      ->React.array}
    </Attachment.Group>
  </div>
