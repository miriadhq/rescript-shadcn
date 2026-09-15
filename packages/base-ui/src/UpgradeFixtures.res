module DirectionText = {
  @react.component
  let make = () => (DirectionProvider.useDirection() :> string)->React.string
}

let direction = <DirectionProvider direction=Rtl> <DirectionText /> </DirectionProvider>

let avatar =
  <Avatar.Root>
    <Avatar.Image keepMounted=true src="/avatar.png" alt="Avatar" />
  </Avatar.Root>

let progress =
  <Progress.Root value=42. getAriaValueText={(formatted, _) => `Completed ${formatted}`} />

let updateToast = (manager, id) =>
  Toast.updateWith(manager, id, previous => {
    title: previous.title->Option.getOr("") ++ " updated",
  })

type city = {id: string, name: string}
let cities = Combobox.Items.create(
  Some([{id: "paris", name: "Paris"}]),
  {
    getValue: city => String(city.id),
    getLabel: city => city.name,
  },
)
let combobox =
  <Combobox.Root.WithItems items=cities defaultValue={Value(String("paris"))}>
    <Combobox.Input />
  </Combobox.Root.WithItems>
