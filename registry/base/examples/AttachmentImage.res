@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex w-full max-w-md gap-3">
    <Attachment orientation=Vertical className="w-40">
      <Attachment.Media variant=Image>
        <img
          src="https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=400&auto=format&fit=crop&q=80"
          alt="Analytics dashboard"
          className="grayscale"
        />
      </Attachment.Media>
      <Attachment.Content>
        <Attachment.Title> {"dashboard.png"->React.string} </Attachment.Title>
        <Attachment.Description> {"PNG - 820 KB"->React.string} </Attachment.Description>
      </Attachment.Content>
    </Attachment>
    <Attachment orientation=Vertical className="w-40">
      <Attachment.Media variant=Image>
        <img
          src="https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=400&auto=format&fit=crop&q=80"
          alt="Laptop with notes"
          className="grayscale"
        />
      </Attachment.Media>
      <Attachment.Content>
        <Attachment.Title> {"research.jpg"->React.string} </Attachment.Title>
        <Attachment.Description> {"JPEG - 1.1 MB"->React.string} </Attachment.Description>
      </Attachment.Content>
    </Attachment>
  </div>
