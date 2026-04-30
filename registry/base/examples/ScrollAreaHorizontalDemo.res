type artwork = {
  artist: string,
  art: string,
}

let works: array<artwork> = [
  {
    artist: "Ornella Binni",
    art: "https://images.unsplash.com/photo-1465869185982-5a1a7522cbcb?auto=format&fit=crop&w=300&q=80",
  },
  {
    artist: "Tom Byrom",
    art: "https://images.unsplash.com/photo-1548516173-3cabfa4607e9?auto=format&fit=crop&w=300&q=80",
  },
  {
    artist: "Vladimir Malyavko",
    art: "https://images.unsplash.com/photo-1494337480532-3725c85fd2ab?auto=format&fit=crop&w=300&q=80",
  },
]

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <ScrollArea className="w-96 rounded-md border whitespace-nowrap">
    <div className="flex w-max space-x-4 p-4">
      {works
      ->Array.map(artwork =>
        <figure key={artwork.artist} className="shrink-0">
          <div className="overflow-hidden rounded-md">
            <img
              src={artwork.art}
              alt={`Photo by ${artwork.artist}`}
              className="aspect-[3/4] h-fit w-fit object-cover"
              width="300"
              height="400"
            />
          </div>
          <figcaption className="text-muted-foreground pt-2 text-xs">
            {"Photo by "->React.string}
            <span className="text-foreground font-semibold"> {artwork.artist->React.string} </span>
          </figcaption>
        </figure>
      )
      ->React.array}
    </div>
    <ScrollArea.ScrollBar orientation=Horizontal />
  </ScrollArea>
