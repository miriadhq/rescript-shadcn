type song = {
  title: string,
  artist: string,
  album: string,
  duration: string,
}

let music = [
  {
    title: "Midnight City Lights",
    artist: "Neon Dreams",
    album: "Electric Nights",
    duration: "3:45",
  },
  {
    title: "Coffee Shop Conversations",
    artist: "The Morning Brew",
    album: "Urban Stories",
    duration: "4:05",
  },
  {
    title: "Digital Rain",
    artist: "Cyber Symphony",
    album: "Binary Beats",
    duration: "3:30",
  },
]

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="flex w-full max-w-md flex-col gap-6">
    <Item.Group className="gap-4">
      {music
      ->Array.map(song =>
        <Item key={song.title} variant=Item.Variant.Outline render={<a href="#" />}>
          <Item.Media variant=Item.Media.Variant.Image>
            <img
              src={`https://avatar.vercel.sh/${song.title}`}
              alt={song.title}
              width="32"
              height="32"
              className="object-cover grayscale"
            />
          </Item.Media>
          <Item.Content>
            <Item.Title className="line-clamp-1">
              {`${song.title} - `->React.string}
              <span className="text-muted-foreground"> {song.album->React.string} </span>
            </Item.Title>
            <Item.Description> {song.artist->React.string} </Item.Description>
          </Item.Content>
          <Item.Content className="flex-none text-center">
            <Item.Description> {song.duration->React.string} </Item.Description>
          </Item.Content>
        </Item>
      )
      ->React.array}
    </Item.Group>
  </div>
