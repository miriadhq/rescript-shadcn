let _dialog = <Dialog.Root open_=true> {React.null} </Dialog.Root>
let _alertDialog = <AlertDialog.Root open_=false> {React.null} </AlertDialog.Root>
let _button = <Button> {React.string("Click")} </Button>
let _checkbox = <Checkbox.Root checked=true> {React.null} </Checkbox.Root>
let _menu = <Menu.Root open_=true> {React.null} </Menu.Root>
let _select = <Select.Root value="one"> {React.null} </Select.Root>
let _tooltip = <Tooltip.Root open_=true> {React.null} </Tooltip.Root>
let _switch = <Switch.Root checked={false}> {React.null} </Switch.Root>
let _toggleGroup = <ToggleGroup value=["a"]> {React.null} </ToggleGroup>
let _scrollArea = <ScrollArea.Root> {React.null} </ScrollArea.Root>
let _autocomplete = <Autocomplete.Root value="one"> {React.null} </Autocomplete.Root>
let _checkboxGroup = <CheckboxGroup value={["one"]}> {React.null} </CheckboxGroup>
let _drawer = <Drawer.Root open_=false> {React.null} </Drawer.Root>
let _drawerSwipeArea = <Drawer.SwipeArea />
let _field = <Field.Root name="email"> {React.null} </Field.Root>
let _form = <Form validationMode=Form.ValidationMode.OnSubmit> {React.null} </Form>
let _meter = <Meter.Root value=50.0> {React.null} </Meter.Root>
let _numberField = <NumberField.Root value=1.0> {React.null} </NumberField.Root>
let _otpField = <OTPField.Root length=6> <OTPField.Input /> </OTPField.Root>
let _toast = <Toast.Provider> {React.null} </Toast.Provider>
let _toolbar = <Toolbar.Root> {React.null} </Toolbar.Root>

let _rendered = Render.use({defaultTagName: "div"})

@react.component
let make = () => {
  let _direction = DirectionProvider.useDirection()
  React.null
}
