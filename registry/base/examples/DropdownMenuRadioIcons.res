@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (paymentMethod, setPaymentMethod) = React.useState(() => "card")

  <DropdownMenu>
    <DropdownMenu.Trigger render={<Button variant=Outline dataSlot="dropdown-menu-trigger" />}>
      {"Payment Method"->React.string}
    </DropdownMenu.Trigger>
    <DropdownMenu.Content className="min-w-56">
      <DropdownMenu.Group>
        <DropdownMenu.Label> {"Select Payment Method"->React.string} </DropdownMenu.Label>
        <DropdownMenu.RadioGroup
          value={paymentMethod} onValueChange={(v, _) => setPaymentMethod(_ => v)}
        >
          <DropdownMenu.RadioItem value="card">
            <Icons.CreditCard />
            {"Credit Card"->React.string}
          </DropdownMenu.RadioItem>
          <DropdownMenu.RadioItem value="paypal">
            <Icons.Wallet />
            {"PayPal"->React.string}
          </DropdownMenu.RadioItem>
          <DropdownMenu.RadioItem value="bank">
            <Icons.Building2 />
            {"Bank Transfer"->React.string}
          </DropdownMenu.RadioItem>
        </DropdownMenu.RadioGroup>
      </DropdownMenu.Group>
    </DropdownMenu.Content>
  </DropdownMenu>
}
