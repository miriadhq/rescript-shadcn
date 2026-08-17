@@directive("'use client'")

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) => {
  let (paymentMethod, setPaymentMethod) = React.useState(() => "card")
  <DropdownMenu.Trigger>
    <Button variant=Outline className="w-fit"> {"Payment Method"->React.string} </Button>
    <DropdownMenu className="min-w-56">
      <DropdownMenu.Group
        selectionMode=Single
        selectedKeys={[paymentMethod]}
        onSelectionChange={selection =>
          switch selection {
          | ReactAria.Common.Selection.Keys(keys) =>
            setPaymentMethod(_ =>
              keys->Set.values->IteratorObject.toArray->Array.get(0)->Option.getOr("card")
            )
          | ReactAria.Common.Selection.All => setPaymentMethod(_ => "card")
          }}
      >
        <DropdownMenu.Label> {"Select Payment Method"->React.string} </DropdownMenu.Label>
        <DropdownMenu.Item id="card">
          <Icons.CreditCard />
          {"Credit Card"->React.string}
        </DropdownMenu.Item>
        <DropdownMenu.Item id="paypal">
          <Icons.Wallet />
          {"PayPal"->React.string}
        </DropdownMenu.Item>
        <DropdownMenu.Item id="bank">
          <Icons.Building2 />
          {"Bank Transfer"->React.string}
        </DropdownMenu.Item>
      </DropdownMenu.Group>
    </DropdownMenu>
  </DropdownMenu.Trigger>
}
